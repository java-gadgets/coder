package org.pplm.gadgets.coder.bean;

import java.util.List;

public abstract class Example {

	public abstract String getOrderByClause();

	public abstract void setOrderByClause(String orderByClause);

	public abstract boolean isDistinct();

	public abstract void setDistinct(boolean distinct);

	public abstract List<? extends BaseCriteria> getOredCriteria();
	
	public abstract void or(BaseCriteria criteria);
	
	public abstract BaseCriteria or();
	
	public abstract BaseCriteria createCriteria();
	
	public abstract void clear();

	public abstract static class BaseCriteria {
    
		protected abstract void addCriterion(String condition);
        
		protected abstract void addCriterion(String condition, Object value, String property);
        
		protected abstract void addCriterion(String condition, Object value1, Object value2, String property);
        
		public abstract BaseCriteria andDeleteFlagEqualTo(Integer value);
	
	}
    
}
