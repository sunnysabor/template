package com.taobao.chenbao.template.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.Map;
import java.util.Random;

/**
 * @Description:首页
 * @Author jerry
 * Date 2020/6/5 9:38 上午
 **/
@Controller
public class IndexController {
    /**
     * 默认页<br/>
     *
     * @RequestMapping("/") 和 @RequestMapping 是有区别的
     * 如果不写参数，则为全局默认页，加入输入404页面，也会自动访问到这个页面。
     * 如果加了参数“/”，则只认为是根页面。
     * 可以通过localhost:8080或者localhost:8080/index访问该方法
     */
    @RequestMapping(value = {"/", "/index"})
    public String index(Map<String, Object> model) {
        // 直接返回字符串，框架默认会去 spring.view.prefix 目录下的 （index拼接spring.view.suffix）页面
        // 本例为 /WEB-INF/jsp/index.jsp
        model.put("time", new Date());
        model.put("message", "hello world");
        return "login";
    }


    @GetMapping(value = "/check")
    public void checkCode(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        check(request, response, session);
    }


    // 验证码
    private void check(HttpServletRequest request,
                       HttpServletResponse response, HttpSession session) {
        response.setContentType("image/jpeg");
        OutputStream os = null;
        try {
            os = response.getOutputStream();
        } catch (IOException e1) {
            e1.printStackTrace();
        }
        int width = 83, height = 30;
        // 建立buffer
        BufferedImage image = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_BGR);
        Graphics g = image.getGraphics();
        Color c = g.getColor();
        // 填充举行
        g.fillRect(0, 0, width, height);
        // 结果
        int result = 0;

        // 设置字体
        g.setFont(getfont());
        String[] calc = {"+", "-"};
        Random random = new Random();
        int num1 = random.nextInt(10);
        int num2 = random.nextInt(10);
        int index = random.nextInt(2);
        // 获取运算符
        String ran = calc[index];
        if (ran.equals("+")) {
            result = num1 + num2;
        } else if (ran.equals("-")) {
            result = num1 - num2;
        }

        g.setColor(new Color(random.nextInt(255), random.nextInt(255), random
                .nextInt(255)));
        g.drawString(String.valueOf(num1), 20 + 6, 25);
        g.drawString(String.valueOf(ran), 20 * 1 + 30, 25);
        g.drawString(String.valueOf(num2), 20 * 3 + 1, 25);

        // 设置随机干扰电
        for (int i = 0; i < 20; i++) {
            // /Random random=new Random();
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            g.drawOval(x1, y1, 2, 2);
        }
        g.setColor(c);
        g.dispose();
        session.setAttribute("code", result + "");
        request.getSession().setAttribute("code", result + "");
        try {
            ImageIO.write(image, "jpeg", os);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    // 产生随机字体
    private Font getfont() {
        Random random = new Random();
        Font font[] = new Font[5];
        font[0] = new Font("Ravie", Font.PLAIN, 24);
        font[1] = new Font("Antique", Font.PLAIN, 24);
        font[2] = new Font("Forte", Font.PLAIN, 24);
        font[3] = new Font("Wide Latin", Font.PLAIN, 24);
        font[4] = new Font("Gill Sans Ultra Bold", Font.PLAIN, 24);
        return font[random.nextInt(5)];

    }
}
