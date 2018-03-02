<#include "spec/" + project.custom + "/package-prefix.ftl" ignore_missing=true />
package ${packagePrefix!}bean;

import ${packagePrefix!}base.${code?cap_first}Base;

public class ${code?cap_first} extends ${code?cap_first}Base {

}
