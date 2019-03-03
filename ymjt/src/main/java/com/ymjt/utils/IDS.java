package com.ymjt.utils;

import java.util.UUID;

public class IDS {
    public static String getId() {
        return UUID.randomUUID().toString().replace("-", "");
    }
}
