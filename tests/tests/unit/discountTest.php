<?php
namespace mod_discount;

require_once realpath(dirname(__FILE__) . '/../..') . '/enviroment.php';

doLogin();

/**
 * Generated by PHPUnit_SkeletonGenerator 1.2.1 on 2013-07-02 at 11:18:02.
 */
class discountTest extends \PHPUnit_Framework_TestCase
{
    /**
     * @var discount
     */
    protected $object;

    /**
     * Sets up the fixture, for example, opens a network connection.
     * This method is called before a test is executed.
     */
    protected function setUp()
    {
        $this->object = new discount;
    }

    /**
     * Tears down the fixture, for example, closes a network connection.
     * This method is called after a test is executed.
     */
    protected function tearDown()
    {
    }

    /**
     * @covers mod_discount\discount::init
     */
    public function testInit()
    {
        $this->assertTrue(true);
    }

    /**
     * @covers mod_discount\discount::get_result_discount
     * @todo   Implement testGet_result_discount().
     */
    public function testGet_result_discount()
    {
        // Remove the following lines when you implement this test.
        $this->markTestIncomplete(
          'This test has not been implemented yet.'
        );
    }

    /**
     * @covers mod_discount\discount::get_user_discount
     * @todo   Implement testGet_user_discount().
     */
    public function testGet_user_discount()
    {
        // Remove the following lines when you implement this test.
        $this->markTestIncomplete(
          'This test has not been implemented yet.'
        );
    }

    /**
     * @covers mod_discount\discount::get_user_group_discount
     * @todo   Implement testGet_user_group_discount().
     */
    public function testGet_user_group_discount()
    {
        // Remove the following lines when you implement this test.
        $this->markTestIncomplete(
          'This test has not been implemented yet.'
        );
    }

    /**
     * @covers mod_discount\discount::get_comulativ_discount
     * @todo   Implement testGet_comulativ_discount().
     */
    public function testGet_comulativ_discount()
    {
        // Remove the following lines when you implement this test.
        $this->markTestIncomplete(
          'This test has not been implemented yet.'
        );
    }

    /**
     * @covers mod_discount\discount::get_discount_products
     * @todo   Implement testGet_discount_products().
     */
    public function testGet_discount_products()
    {
        // Remove the following lines when you implement this test.
        $this->markTestIncomplete(
          'This test has not been implemented yet.'
        );
    }

    /**
     * @covers mod_discount\discount::get_all_order_discount_register
     * @todo   Implement testGet_all_order_discount_register().
     */
    public function testGet_all_order_discount_register()
    {
        // Remove the following lines when you implement this test.
        $this->markTestIncomplete(
          'This test has not been implemented yet.'
        );
    }

    /**
     * @covers mod_discount\discount::get_all_order_discount_not_register
     * @todo   Implement testGet_all_order_discount_not_register().
     */
    public function testGet_all_order_discount_not_register()
    {
        // Remove the following lines when you implement this test.
        $this->markTestIncomplete(
          'This test has not been implemented yet.'
        );
    }
}
