package com.taihaoli.util;

import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.PiePlot3D;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * @author HuangDongChang
 * @date 2019/1/7
 */
public class ChartUtils {

    public static final String CHART_PATH = "E:/";
    private static final Logger log = LoggerFactory.getLogger(ChartUtils.class);

    /**
     * 提供静态方法：获取报表图形1：饼状图
     * @param title    标题
     * @param datas    数据
     * @param font    字体
     */
    public static BufferedImage createPieChart(String title, Map<String, Object> datas, Font font) {
        DefaultPieDataset dateSet = new DefaultPieDataset();
        Set<Map.Entry<String, Object>> data = datas.entrySet();
        for (Object object : data) {
            Map.Entry entry = (Map.Entry) object;
            dateSet.setValue(entry.getKey().toString(), Double.parseDouble(entry.getValue().toString()));
        }

        /**
         *  生成一个饼图的图表
         *  显示图表的标题、需要提供对应图表的DateSet对象、是否显示图例、是否生成贴士以及是否生成URL链接
         */
        JFreeChart chart = ChartFactory.createPieChart(title, dateSet, true, false, true);

        // 设置图片标题的字体
        chart.getTitle().setFont(font);
        // 得到图块,准备设置标签的字体
        PiePlot plot = (PiePlot) chart.getPlot();
        // 设置标签字体
        plot.setLabelFont(font);
        // 设置图例项目字体
        chart.getLegend().setItemFont(font);
        // 设置开始角度(弧度计算)
        plot.setStartAngle(new Float(3.14f / 2f));

        //设置plot的前景色透明度
        plot.setForegroundAlpha(0.7f);

        //设置plot的背景色透明度
        plot.setBackgroundAlpha(0.0f);

        //设置标签生成器(默认{0})
        //{0}:key {1}:value {2}:百分比 {3}:sum
        plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0}({1})/{2}"));
        // 设置描述格式
        plot.setLegendLabelGenerator(new StandardPieSectionLabelGenerator("{0}({1})/{2}"));
        return chart.createBufferedImage(700, 800);
        /*try {
            // 文件夹不存在则创建
            isChartPathExist(CHART_PATH);
            String chartName = CHART_PATH + charName;
            //将内存中的图片写到本地硬盘
            ChartUtilities.saveChartAsPNG(new File(chartName), chart, 600, 300);
            log.info("pie chart create success");

        } catch (IOException e) {
            e.printStackTrace();
        }*/
    }

    /**
     * 判断文件夹是否存在，如果不存在则新建
     *
     * @param chartPath
     */
    private static void isChartPathExist(String chartPath) {
        File file = new File(chartPath);
        if (!file.exists()) {
            boolean result = file.mkdirs();
            log.info("CHART_PATH=" + CHART_PATH + "create " + result);
        }
    }

    /**
     * 提供静态方法：获取报表图形2：柱状图
     *
     * @param title    标题
     * @param datas    数据
     * @param unit     柱状图的数量单位
     * @param font     字体
     * @param charName 图表名称
     */
    public static void createBarChart(String title, Map<String, Map<String, Double>> datas, Font font, String unit, String charName) {
        try {
            //种类数据集
            DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
            Set<Map.Entry<String, Map<String, Double>>> data = datas.entrySet();
            for (Object object : data) {
                Map.Entry entry = (Map.Entry) object;
                Map<String, Double> map = (Map<String, Double>) entry.getValue();
                for (Object obj : map.entrySet()
                        ) {
                    Map.Entry entryChild = (Map.Entry) obj;
                    dataSet.setValue(Double.parseDouble(entryChild.getValue().toString()),
                            entryChild.getKey().toString(), entry.getKey().toString());
                }
            }

            //创建柱状图,柱状图分水平显示和垂直显示两种
            JFreeChart chart = ChartFactory.createBarChart(title, "", unit,
                    dataSet, PlotOrientation.VERTICAL, true, true, true);

            //设置整个图片的标题字体
            chart.getTitle().setFont(font);
            //设置提示条字体
            font = new Font("宋体", Font.BOLD, 15);
            chart.getLegend().setItemFont(font);
            //得到绘图区
            CategoryPlot plot = (CategoryPlot) chart.getPlot();
            //得到绘图区的域轴(横轴),设置标签的字体
            plot.getDomainAxis().setLabelFont(font);
            //设置横轴标签项字体
            plot.getDomainAxis().setTickLabelFont(font);
            //设置范围轴(纵轴)字体
            plot.getRangeAxis().setLabelFont(font);
            //存储成图片
            plot.setForegroundAlpha(1.0f);
            ChartUtilities.saveChartAsPNG(new File(CHART_PATH + charName), chart, 600, 400);
            log.info("bar chart create success");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 提供静态方法：获取报表图形3：折线图
     *
     * @param title    标题
     * @param datas    数据
     * @param unit     柱状图的数量单位
     * @param font     字体
     * @param charName 图表名称
     */
    public static void createLineChart(String title, Map<String, Map<String, Double>> datas, String unit, Font font, String charName) {
        try {
            //种类数据集
            DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
            Set<Map.Entry<String, Map<String, Double>>> data = datas.entrySet();
            for (Object object : data) {
                Map.Entry entry = (Map.Entry) object;
                Map<String, Double> map = (Map<String, Double>) entry.getValue();
                for (Object obj : map.entrySet()
                        ) {
                    Map.Entry entryChild = (Map.Entry) obj;
                    dataSet.setValue(Double.parseDouble(entryChild.getValue().toString()),
                            entryChild.getKey().toString(), entry.getKey().toString());
                }
            }
            //创建柱状图
            JFreeChart chart = ChartFactory.createLineChart(title, "", unit,
                    dataSet, PlotOrientation.VERTICAL, true, true, true);

            //设置整个图片的标题字体
            chart.getTitle().setFont(font);

            //设置提示条字体
            font = new Font("宋体", Font.BOLD, 15);
            chart.getLegend().setItemFont(font);

            //得到绘图区
            CategoryPlot plot = (CategoryPlot) chart.getPlot();
            //得到绘图区的域轴(横轴),设置标签的字体
            plot.getDomainAxis().setLabelFont(font);

            //设置横轴标签项字体
            plot.getDomainAxis().setTickLabelFont(font);

            //设置范围轴(纵轴)字体
            plot.getRangeAxis().setLabelFont(font);
            //存储成图片
            plot.setForegroundAlpha(1.0f);
            ChartUtilities.saveChartAsPNG(new File(CHART_PATH + charName), chart, 600, 400);
            log.info("line chart create success");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Font font = new Font("宋体", Font.BOLD, 20);

        /*Map<String, Double> map = new HashMap<>();
        map.put("Bug", 1000d);
        map.put("API", 700d);
        map.put("Task", 600d);
        map.put("UI", 400d);
        // 生成饼状图
        createPieChart("label分布", map, font);*/

        Map<String, Map<String, Double>> datas = new HashMap<>();
        Map<String, Double> map1 = new HashMap<>();
        Map<String, Double> map2 = new HashMap<>();
        Map<String, Double> map3 = new HashMap<>();
        //设置第一期的投票信息
        map1.put("ibm", 100d);
        map1.put("google", 300d);
        map1.put("用友", 600d);
        //设置第二期的投票信息
        map2.put("ibm", 200d);
        map2.put("google", 200d);
        map2.put("用友", 800d);
        //设置第三期的投票信息
        map3.put("ibm", 300d);
        map3.put("google", 600d);
        map3.put("用友", 1000d);
        datas.put("第一季度", map1);
        datas.put("第二季度", map2);
        datas.put("第三季度", map3);
        String title = "前三季度各大公司市场销售情况";
        String unit = "销量(万台)";
        createBarChart(title, datas, font, unit, "bar.png");
        createLineChart(title, datas, unit, font, "line.png");

        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("Sheet 1");
        ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
        FileOutputStream fileOut = null;
        try {
            BufferedImage bufferImg = ImageIO.read(new File(CHART_PATH + "pie.png"));
            ImageIO.write(bufferImg, "png", byteArrayOut);
            // 画图的顶级管理器，一个sheet只能获取一个（一定要注意这点）
            HSSFPatriarch patriarch = (HSSFPatriarch) sheet.createDrawingPatriarch();
            // 八个参数，前四个表示图片离起始单元格和结束单元格边缘的位置，
            // 后四个表示起始和结束单元格的位置，如下表示从第10列到第20列，从第1行到第15行,需要注意excel起始位置是0
            HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 0, 0,
                    (short) 10, (short) 1, (short) 20, (short) 15);
            anchor.setAnchorType(3);
            // 插入图片
            patriarch.createPicture(anchor, wb.addPicture(byteArrayOut.toByteArray(), HSSFWorkbook.PICTURE_TYPE_PNG));
            fileOut = new FileOutputStream("E://3.xls");
            wb.write(fileOut);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                fileOut.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


    }

}
