<?php

namespace DeliveryTester;

class DeliverySteps extends \DeliveryTester {

    /**
     * Create Delivery with specified parrameters
     * if you wont to skip some field type null
     * if you want to select several Payment methods pass array
     * 
     * @version 1.2
     * 
     * @param string            $name               Delivery name type null to skip
     * @param sting             $active             Active Checkbox on - enabled| null
     * @param string            $description        Method description type null to skip
     * @param string            $descriptionprice   Method price description type null to skip
     * @param int|float|string  $price              Delivery price type null to skip
     * @param int|float|string  $freefrom           Delivery free from type null to skip
     * @param string            $message            Delivery sum specified message type null to skip
     * @param string            $pay                Payment methods one pay or array of payments
     * @return void
     */
    function createDelivery(
    $name = null, $active = null, $description = null, $descriptionprice = null, $price = null, $freefrom = null, $message = null, $pay = null) {
        $I = $this;
        $I->amOnPage(\DeliveryCreatePage::$URL);
        if (isset($name)) {
            $I->fillField(\DeliveryCreatePage::$FieldName, $name);
        }
        if (isset($active)) {
            $I->checkOption(\DeliveryCreatePage::$CheckboxActive);
        }
        if (isset($description)) {
            $I->fillField(\DeliveryCreatePage::$FieldDescription, $description);
        }
        if (isset($descriptionprice)) {
            $I->fillField(\DeliveryCreatePage::$FieldDescriptionPrice, $descriptionprice);
        }
        if (isset($price)) {
            $I->fillField(\DeliveryCreatePage::$FieldPrice, $price);
        }
        if (isset($freefrom)) {
            $I->fillField(\DeliveryCreatePage::$FieldFreeFrom, $freefrom);
        }
        if (isset($message)) {
            $I->checkOption(\DeliveryCreatePage::$CheckboxPriceSpecified);
            $I->fillField(\DeliveryCreatePage::$FieldPriceSpecified, $message);
        }
        if (isset($pay)) {
            if (is_string($pay)) {
                $I->click($pay);
            }
            if (is_array($pay)) {
                foreach ($pay as $value) {
                    $I->click($value);
                }
            }
        }
        $I->click(\DeliveryCreatePage::$ButtonCreate);
        $I->wait("3");
    }

    /**
     * Delivery searching
     * 
     * Search of delivery method in list and return his row or false if not present
     * @version 1.1
     * @param   type                $methodname name of delivery method which you want to search
     * @return  int|boolean         if Delivery Method is present return method row else return false
     */
    function SearchDeliveryMethod($methodname) {
        $I = $this;
        $rows = $I->grabClassCount($I,'niceCheck') - 1;
        $present = FALSE;

        for ($row = 1; $row <= $rows; ++$row) {
            $CMethod = $I->grabTextFrom(\DeliveryPage::ListMethodLine($row));

            if ($CMethod == $methodname) {
                $present = TRUE;
                break;
            }
        }
        return $present ? $row : $present;
    }

    /**
     * Checking current parameters in frontend 
     * first time goes "processing order" page by clicking, other times goes to "processing order" page immediately
     * if you want to skip verifying of some parameters type null
     * 
     * @version 1.0
     * 
     * @param string            $DeliveryName           Delivery name
     * @param string            $description            Description
     * @param float|int|string  $price                  Delivery price
     * @param float|int|string  $freefrom               Delivery free from
     * @param string            $message                Delivery sum specified message
     * @param string|array      $pay                    Delivery Payment methods, which will included, if passed string : "_" - delimiter for few methods 
     * @return void
     */
    function CheckInFrontEnd($DeliveryName, $description = null, $price = null, $freefrom = null, $message = null, $pay = null) {
        $I = $this;

        static $WasCalled = FALSE;
        if (!$WasCalled) {
            $I->amOnPage('/shop/product/mobilnyi-telefon-sony-xperia-v-lt25i-black');

            /**
             * @var string buy          button "buy"
             * @var string basket       button "into basket"
             * @var string $Attribute1  class of "buy" button
             */
            $buy = "//div[@class='frame-prices-buy f-s_0']//form/div[3]";
            $basket = "//div[@class='frame-prices-buy f-s_0']//form/div[2]";

            $I->wait(10);
            try {
                $I->click($buy);
            } catch (\Exception $exc) {
                $I->click($basket);
            }
            $I->waitForElementVisible("//*[@id='popupCart']", 10);
            $I->click(".btn-cart.btn-cart-p.f_r");
        } else {
            $I->amOnPage("/shop/cart");
        }


        $WasCalled = TRUE;
        $present = FALSE;


        $I->waitForText('Оформление заказа');
        $ClassCount = $I->grabClassCount($I, 'name-count');

        for ($j = 1; $j <= $ClassCount; ++$j) {
            $CName = $I->grabTextFrom("//div[@class='frame-radio']/div[$j]//span[@class='text-el']");

            if ($CName == $DeliveryName) {
                $present = TRUE;
                break;
            }
        }

        //Error when method isn't present in front end
        $present ? $I->assertEquals($DeliveryName, $CName) : $I->fail("Delivery method isn't present in front end");
        if ($description) {
            $Cdescription = $I->grabAttributeFrom("//div[@class='frame-radio']/div[$j]//span[@class='icon_ask']", 'data-title');
            $I->assertEquals($Cdescription, $description);
        }

        if ($price) {
            $Cprice = $I->grabTextFrom("//div[@class='frame-radio']/div[$j]/div[@class='help-block']/div[1]");
            $Cprice = preg_replace('/[^0-9.]*/u', '', $Cprice);
            $price = ceil($price);
            $I->assertEquals($Cprice, $price);
        }

        if ($freefrom) {
            $Cfreefrom = $I->grabTextFrom("//div[@class='frame-radio']/div[$j]/div[@class='help-block']/div[2]");
            $Cfreefrom = preg_replace('/[^0-9.]*/u', '', $Cfreefrom);
            $freefrom = ceil($freefrom);
            $I->assertEquals($Cfreefrom, $freefrom);
        }

        if ($message) {
            $Cmessage = $I->grabTextFrom("//div[@class='frame-radio']/div[$j]/div[@class='help-block']");
            $I->comment($Cmessage);
            $I->assertEquals($Cmessage, $message);
        }

        if ($pay) {
            $JQScrollToclick = "$('html,body').animate({scrollTop:$('div.frame-radio>div:nth-child($j)').offset().top});";
            $I->executeJS($JQScrollToclick);
            $I->wait(5);
            $I->click("//div[@class='frame-radio']/div[$j]//span[@class='text-el']");
            $sc = "$('html,body').animate({scrollTop:$('#submitOrder').offset().top},'fast');";
            $I->executeJS($sc);

            if ($pay == 'off') {
                $I->waitForText('Нет способов оплаты', NULL, '//div[@class="frame-form-field"]/div[@class="help-block"]');
                $I->see('Нет способов оплаты', '//div[@class="frame-form-field"]/div[@class="help-block"]');
            } else {
                $I->waitForElementVisible("#cuselFrame-paymentMethod");
                $I->click(".cuselText");
                is_string($pay) ? $pay = explode("_", $pay) : print "";
                $j = 1;
                foreach ($pay as $value) {
                    $Cpay = $I->grabTextFrom("//div[@id='cusel-scroll-paymentMethod']/span[$j]");
                    $I->assertEquals($Cpay, $value);
                    $j++;
                }
            }
        }
    }

    /**
     * FrontEnd present
     * 
     * Check that delivery method is not present in processing order  page of Front End
     * 
     * @staticvar boolean $WasCalled
     * @param AcceptanceTester $I controller
     * @param type $name Delivery Method name
     */
    function CheckMethodNotPresentInFrontEnd($name) {
        $I = $this;
        
        static $WasCalled = FALSE;
        
        if (!$WasCalled) {
            $I->amOnPage('/shop/product/mobilnyi-telefon-sony-xperia-v-lt25i-black');
            
            $buy = "//div[@class='frame-prices-buy f-s_0']//form/div[3]";
            $basket = "//div[@class='frame-prices-buy f-s_0']//form/div[2]";
            $I->wait(10);
            try {
                $I->click($buy);
            } catch (\Exception $exc) {
                $I->click($basket);
            }
            $I->waitForElementVisible("//*[@id='popupCart']",10);
            $I->click(".btn-cart.btn-cart-p.f_r");
        } else {
            $I->amOnPage("/shop/cart");
        }

        $WasCalled = TRUE;
        $missing = TRUE;
        $I->waitForText('Оформление заказа');
        /**
         * @var int $ClassCount number of all delivery methods available in processing order  page(front)
         */
        $ClassCount = $I->grabClassCount($I, 'name-count');

        for ($j = 1; $j <= $ClassCount;  ++$j) {
            /**
             * @var string $CNmame name of delivery method in current row 
             */
            $CName = $I->grabTextFrom("//div[@class='frame-radio']/div[$j]//span[@class='text-el']");

            if ($CName == $name) {
                $missing = FALSE;
                break;
            }
        }
        return $missing;
    }
    /**
     * @param array             $Methods    Names of delivery methods which you want to delete         
     */
    function DeleteDeliveryMethods ($Methods) {
        $I = $this;
        $I->amOnPage(\DeliveryPage::$URL);

        $AllMethodsCount = $I->grabClassCount($I, "niceCheck")-1;
        for ($row = 1;$row <= $AllMethodsCount;++$row){
            $CurrentRowMethod = $I->grabTextFrom(\DeliveryPage::ListMethodLine($row));
            if(is_array($Methods)){
                if(in_array($CurrentRowMethod, $Methods)){
                        $I->click (\DeliveryPage::ListCheckboxLine ($row));
                        $HaveMethodsToDelete = true;
                }
            }
            else {
                if($CurrentRowMethod == $Methods){
                        $I->click (\DeliveryPage::ListCheckboxLine ($row));
                        $HaveMethodsToDelete = true;
                    }        
            }   
        }
        if($HaveMethodsToDelete){
            $I->click(\DeliveryPage::$DeleteButton);
            $I->waitForText("Удаление способов доставки", NULL, "//*[@id='mainContent']/div/div[1]/div[1]/h3");
            $I->click(\DeliveryPage::$DeleteWindowDelete);
            $this->CheckForAlertPresent('success', 'delete');
        }
    }
    /**
     * Checking that alerts is present after clicking create button
     * 
     * @param string    $type       error|success|required
     * @param string    $module     create|edit|delete|drag
     * @return void
     */
    function CheckForAlertPresent($type,$module) {
        $I = $this;
        switch ($type){
            case 'error':
                    $I->comment("I want to see that error alert is present");
                    $I->waitForElementVisible('.alert.in.fade.alert-error');
                    $I->waitForElementNotVisible('.alert.in.fade.alert-error');
                    ///edit or create
                    //$I->see("Создание способа доставки", '.title');
                    break;
            case 'success':
                    $I->comment("I want to see that success alert is present");
                    $I->waitForElementVisible('.alert.in.fade.alert-success');
                    if      ($module == 'create')   { $I->see('Доставка создана','.alert.in.fade.alert-success'); }
                    elseif  ($module == 'edit')     { $I->see('Изменения сохранены','.alert.in.fade.alert-success'); }
                    elseif  ($module == 'delete')   { $I->see('Способ доставки удален','.alert.in.fade.alert-success'); }
                    elseif  ($module == 'drag')     { $I->see('Позиции сохранены', '.alert.in.fade.alert-success'); }
                    $I->waitForElementNotVisible('.alert.in.fade.alert-success');
                    break;
            //Checking required field (red color(class alert) & message 
            case 'required':
                    $I->comment("I want to see that field is required");
                    $I->waitForElementVisible('//label[@generated="true"]');
                    $I->see('Это поле обязательное.', 'label.alert.alert-error');
                    if      ($module=='create') { $I->assertEquals($I->grabAttributeFrom(\DeliveryCreatePage::$FieldName, 'class'), "alert alert-error");}
                    elseif  ($module=='edit')   { $I->assertEquals($I->grabAttributeFrom(\DeliveryEditPage::$FieldName, 'class'), "required alert alert-error");}
                    break;
                default :
                    $I->fail("unknown type of error entered");
        }
    }

}
