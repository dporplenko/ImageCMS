<?php

namespace Banners\UrlFinder\Finders;

use Banners\UrlFinder\Results\Result;

final class ProductCategories implements FinderInterface {

    protected $table = 'shop_category';
    protected $translations = 'shop_category_i18n';
    protected $nameColumn = 'shop_category_i18n.name';
    protected $urlColumn = 'shop_category.url';
    protected $langColumn = 'shop_category_i18n.locale';

    /**
     * @return string
     */
    public function getGroupName() {
        return lang('Product Categories', 'xbanners');
    }

    /**
     * @param string $word
     * @param string $language
     * @param int $limit
     * @return Result
     */
    public function getResultsFor($word, $language, $limit) {
        /* @var $db \CI_DB_active_record */
        $db = \CI::$APP->db;
        $results = $db->select("$this->nameColumn, $this->urlColumn")
                ->from($this->table)
                ->join($this->translations, "{$this->table}.id = {$this->translations}.id")
                ->like($this->nameColumn, $word)
                ->where($this->langColumn, $language)
                ->limit($limit)
                ->get()
                ->result_array();
        $result = new Result($this->getGroupName());
        foreach ($results as $oneResult) {
            $result->addResult($oneResult['name'], $this->formUrl($oneResult['url']));
        }
        return $result;
    }

    /**
     * @param string $url
     * @return string
     */
    public function formUrl($url) {
        return '/shop/category/' . $url;
    }

}
