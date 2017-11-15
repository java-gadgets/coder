package org.pplm.gadgets.coder.controller;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

import org.pplm.gadgets.coder.entity.Func;
import org.pplm.gadgets.coder.repository.FuncRepository;
import org.pplm.gadgets.coder.utils.ResHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@RestController
@RequestMapping(path = "/v1/gen", produces = MediaType.APPLICATION_JSON_VALUE)
public class GeneratorController {
	
	@Autowired
	private FuncRepository funcRepository;
/*
	{
    "label":"测试",
    "name": "test",
    "attrs":[
    {
        "label":"测试1",
        "name": "test1"
    },
    {
        "label":"测试2",
        "name": "test2"
    }

   ]
	}
*/
	@PostMapping(path = "/vue/{id}")
	public Map<String, Object> onPostList (@PathVariable(name = "id") String id, @RequestParam(name = "type", required = false, defaultValue = "list") String type) throws IOException, TemplateException {
		Func func = funcRepository.findOne(Long.parseLong(id));
		if (func == null) {
			return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
		}
		String result = genCode(func, type + ".ftl");
		System.out.println(result);
		return ResHelper.success(result);
	}
	
	private String genCode(Func func, String templateFileName) throws IOException, TemplateException {
		Configuration config = new Configuration(Configuration.VERSION_2_3_26);
		Resource resouce = new ClassPathResource("templates");
		config.setDirectoryForTemplateLoading(resouce.getFile());
		config.setDefaultEncoding("utf-8");
		Template template = config.getTemplate(templateFileName, "utf-8");
		StringWriter stringWriter = new StringWriter();
		template.process(func, stringWriter);
		return stringWriter.toString();
	}
	
}
