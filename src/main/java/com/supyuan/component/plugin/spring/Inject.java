package com.supyuan.component.plugin.spring;

import java.lang.annotation.*;

/**
 * Inject.
 */
public class Inject {
    
    private Inject() {}
    
    @Inherited
    @Retention(RetentionPolicy.RUNTIME)
    @Target({ElementType.FIELD})
    public static @interface BY_TYPE {}
    
    @Inherited
    @Retention(RetentionPolicy.RUNTIME)
    @Target({ElementType.FIELD})
    public static @interface BY_NAME {}
    
    /*
    @Inherited
    @Retention(RetentionPolicy.RUNTIME)
    @Target({ElementType.FIELD})
    public static @interface IGNORE {}
    */
}



