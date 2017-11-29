package org.pplm.gadgets.coder.controller;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

import org.pplm.gadgets.coder.entity.Base;
import org.pplm.gadgets.coder.entity.Dict;
import org.pplm.gadgets.coder.entity.Func;
import org.pplm.gadgets.coder.entity.Opt;
import org.pplm.gadgets.coder.repository.DictRepository;
import org.pplm.gadgets.coder.repository.FuncRepository;
import org.pplm.gadgets.coder.repository.OptRepository;
import org.pplm.gadgets.coder.utils.ResHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.http.MediaType;
import org.springframework.ui.freemarker.SpringTemplateLoader;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@RestController
@RequestMapping(path = "/v1/gen", produces = MediaType.APPLICATION_JSON_VALUE)
public class GeneratorController {
	
	@Autowired
	private FuncRepository funcRepository;
	
	@Autowired
	private OptRepository optRepository;
	
	@Autowired
	private DictRepository dictRepository;

	@PostMapping(path = "/vue/{id}")
	public Map<String, Object> onPostList (@PathVariable(name = "id") String id, @RequestParam(name = "type", required = false, defaultValue = "list") String type, @RequestParam(name = "project", required = false, defaultValue = "wsh") String project) throws IOException, TemplateException {
		Func func = funcRepository.findOne(id);
		if (func == null) {
			return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
		}
		return ResHelper.success(genCode(func, type + ".ftl", "/" + project + "/iview-admin"));
	}
	
	@PostMapping(path = "/vue/dict/{id}")
	public Map<String, Object> onPostDictGen(@PathVariable(name = "id") String id) throws IOException, TemplateException {
		Dict dict = dictRepository.findOne(id);
		return ResHelper.success(genCode(dict, "dict.ftl", ""));
	}
	
	@PostMapping(path = "/vue/opt/{type}/{id}")
	public Map<String, Object> onPostSaveGen(@PathVariable(name = "type") String type, @PathVariable(name = "id") String id) throws IOException, TemplateException {
		Opt opt = optRepository.findOne(id);
		String templateFileName = null;
		if ("update".equals(type) || "add".equals(type) || "save".equals(type)) {
			templateFileName = "save-wsh.ftl";
		} else if ("detail".equals(type)) {
			templateFileName = "detail-wsh.ftl";
		} else {
			return ResHelper.error("invalid type");
		}
		return ResHelper.success(genCode(opt, templateFileName, ""));
	}
	
	private String genCode(Base base, String templateFileName, String path) throws IOException, TemplateException {
		Configuration config = new Configuration(Configuration.VERSION_2_3_26);
		config.setDefaultEncoding("utf-8");
		TemplateLoader templateLoader = new SpringTemplateLoader(new DefaultResourceLoader(), "ftls" + path);
		config.setTemplateLoader(templateLoader);
		Template template = config.getTemplate(templateFileName, "utf-8");
		StringWriter stringWriter = new StringWriter();
		template.process(base, stringWriter);
		return stringWriter.toString();
	}
	
}
