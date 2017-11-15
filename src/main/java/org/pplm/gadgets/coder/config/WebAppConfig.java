package org.pplm.gadgets.coder.config;

import org.pplm.gadgets.coder.interceptor.AuthorizationInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class WebAppConfig extends WebMvcConfigurerAdapter {
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		InterceptorRegistration interceptorRegistration = registry.addInterceptor(new AuthorizationInterceptor());
		interceptorRegistration.excludePathPatterns("/**/system/**");
		interceptorRegistration.addPathPatterns("/**");
		super.addInterceptors(registry);
	}
	
}
