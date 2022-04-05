package com.yutons.shiro.bean.quota.urinalysis;

import com.yutons.shiro.bean.quota.BaseQuota;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @title: 酮体
 * @Author fq
 * @Date: 2022/3/19 16:09
 * @Version 1.0
 */
@Data
@NoArgsConstructor
public class Ketone extends BaseQuota {

    {
        name = "酮体";
        unit = "mmol/L";
    }

    public Ketone(String value) {
        super.value = value;
    }
}
