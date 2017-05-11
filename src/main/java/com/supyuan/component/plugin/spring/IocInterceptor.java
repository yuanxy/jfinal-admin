package com.supyuan.component.plugin.spring;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import org.springframework.context.ApplicationContext;

import java.lang.reflect.Field;

/**
 * IocInterceptor.
 */
public class IocInterceptor implements Interceptor {
    
    public static ApplicationContext ctx;
    
    public void intercept(Invocation ai) {
        Controller controller = ai.getController();
        Field[] fields = controller.getClass().getDeclaredFields();
        for (Field field : fields) {
            Object bean = null;
            if (field.isAnnotationPresent(Inject.BY_NAME.class))
                bean = ctx.getBean(field.getName());
            else if (field.isAnnotationPresent(Inject.BY_TYPE.class))
                bean = ctx.getBean(field.getClass().getName());
            else
                continue ;
            
            try {
                if (bean != null) {
                    field.setAccessible(true);
                    field.set(controller, bean);
                }
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
        
        ai.invoke();
    }
}
