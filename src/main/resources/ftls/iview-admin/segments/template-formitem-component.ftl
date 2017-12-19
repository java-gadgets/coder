<#if attr.type! == "datetime">
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.name!}" format="yyyy-MM-dd HH:mm:ss" type="datetime" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "date">
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.name!}" format="yyyy/MM/dd" type="date" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "year">
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.name!}" format="yyyy" type="date" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "month">
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.name!}" format="yyyy-MM" type="date" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "select">
${spaces!}                    <Select v-model="optForm.${optName!}.${attr.name!}" clearable placeholder="请选择${attr.label!}">
${spaces!}                        <Option v-for="item in dict.${attr.name!}" :value="item.value" :key="item.value">{{ item.label }}</Option>
${spaces!}                    </Select>
<#elseif attr.type! == "radio">
${spaces!}                    <RadioGroup v-model="optForm.${optName!}.${attr.name!}">
${spaces!}                        <Radio v-for="item in dict.${attr.name!}" :label="item.value" :key="item.value">{{ item.label }}</Radio>
${spaces!}                    </RadioGroup>
<#else>
${spaces!}                    <Input type="<#if attr.type! == "textarea">textarea<#elseif attr.type! == "password">password<#else>text</#if>" v-model="optForm.${optName!}.${attr.name!}"></Input>
</#if>
