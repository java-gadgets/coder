<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Create${code?cap_first}Table extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('${c2u(code)}', function (Blueprint $table) {
            $table->increments('id');
<#list attrs as attr >
            $table-><#if attr.datatype! == "string" >string<#elseif attr.datatype! == "integer" >integer<#elseif attr.datatype! == "double" >decimal<#elseif attr.datatype! == "text" >text<#elseif attr.datatype! == "datetime" >dateTime<#else>string</#if>("${c2u(attr.code)}"<#if attr.length?? && attr.length gt 0 >, ${attr.length}</#if><#if attr.precise?? && attr.precise gt 0 >, ${attr.precise!}</#if>)->comment('${attr.name!}<#if (attr.type! == "select" || attr.type! == "radio") && attr.dict?? >, ${attr.dict}</#if><#if attr.remark! != "">;${attr.remark!}</#if>');
</#list>
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('${c2u(code)}');
    }
}
