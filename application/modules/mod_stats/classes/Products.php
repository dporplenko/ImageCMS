<?php

namespace mod_stats\classes;

/**
 * Description of Products
 *
 * @author kolia
 */
class Products extends \MY_Controller {

    protected static $instanse;

    /**
     * 
     * @return Products
     */
    public static function create() {
        (null !== self::$_instance) OR self::$_instance = new self();
        return self::$_instance;
    }

   

    public function getAllBrands() {
        return \mod_stats\models\ProductsBase::getInstance()->getAllBrands();
    }

}

?>
