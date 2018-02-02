<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\${code?cap_first};

class ${code?cap_first}Controller extends Controller
{
    use ExcelHelper;

<#list opts as opt >
<#if opt.type! == "list" >
    public function ${code!}${opt.type?cap_first} (Request $request)
    {
        $limit = $request->get('limit', env('PER_PAGE', 10));
<#list opts as optInner >
<#if optInner.type! == "query" >
<#list optInner.attrs as attr >
        $${attr.code!} = $request->get('${attr.code!}');
</#list>
<#break>
</#if>
</#list>
        $query = DB::table('${c2u(code)}')
        ->select([
<#list attrs as attr >
            '${c2u(attr.code)} as ${attr.code}',
</#list>
        ]);
<#list opts as optInner >
<#if optInner.type! == "query" >
<#list optInner.attrs as attr >
        if (isset(${attr.code!})) $query->where('${c2u(attr.code)}'<#if attr.datatype! == "string" >, 'like'</#if>, "${attr.code!}<#if attr.datatype! == "string" >%</#if>");
</#list>
<#break>
</#if>
</#list>
        return $this->getResponseMessage(0, 'success', $query->paginate($limit));
    }

<#elseif opt.type! == "export" >
    public function ${code!}${opt.type?cap_first} (Request $request)
    {
        $query = DB::table('${c2u(code)}')
        ->select([
<#list opt.attrs as attr >
            '${c2u(attr.code)} as ${attr.code}',
</#list>
        ]);
<#list opts as optInner >
<#if optInner.type! == "query" >
<#list optInner.attrs as attr >
        if (isset(${attr.code!})) $query->where('${c2u(attr.code)}'<#if attr.datatype! == "string" >, 'like'</#if>, "${attr.code!}<#if attr.datatype! == "string" >%</#if>");
</#list>
<#break>
</#if>
</#list>
        $list = $query->get();
<#assign dictFlag = false />
<#list opt.attrs as attr >
<#if (attr.type! == "select" || attr.type! == "radio") && attr.dict?? >
<#assign dictFlag = true />
<#break>
</#if>
</#list>
<#if dictFlag >
<#list opt.attrs as attr >
<#if (attr.type! == "select" || attr.type! == "radio") && attr.dict?? >
        $${attr.code!}Dict = [
<#list attr.dict.dictItems as dictItem >
            '${dictItem.value!}' => '${dictItem.name}',
</#list>
        ];
</#if>
</#list>
        foreach ($list as $item) {
<#list opt.attrs as attr >
<#if (attr.type! == "select" || attr.type! == "radio") && attr.dict?? >
            $item->${attr.code!} = $${attr.code!}Dict[$item->${attr.code!}];
</#if>
</#list>
        }
</#if>
        $title = [
<#list opt.attrs as attr >
        	'${attr.code!}' => '${attr.name!}',
</#list>
        ];
        return $this->exports($list, $title);
    }

<#elseif opt.type! == "save" >
    public function ${code!}${opt.type?cap_first} (Request $request, $id) {
    
    }
    
    public function ${code!}${opt.type?cap_first}Prepare (Request $Request) {
    }
    
<#elseif opt.type! == "update" >
    public function ${code!}${opt.type?cap_first} (Request $request) {
    	$id = $request->input("id");
    	
    	$${code!} = ${code?cap_first}::where('id', $id)->first();
    	if (empty($${code!})) {
    		return $this->getResponseMessage(1, "id不存在");
    	}

<#list attrs as attr >
        $${attr.code!} = $request->input('${attr.code!}');
</#list>

<#list attrs as attr >
        if (isset($${attr.code!})) $${code!}->${c2u(attr.code)} = $${attr.code!};
</#list>

        $${code!}->save();
		
        return $this->getResponseMessage(0, '操作成功');
    }

    public function ${code!}${opt.type?cap_first}Prepare (Request $Request) {
    	$id = $request->input("id");
    	
    	$${code!} = ${code?cap_first}::where('id', $id)->first();
    	if (empty($${code!})) {
    		return $this->getResponseMessage(1, "id不存在");
    	}
    	
    	return $this->getResponseMessage(0, '操作成功', $${code!});
    }

<#else>
</#if>
</#list>
}