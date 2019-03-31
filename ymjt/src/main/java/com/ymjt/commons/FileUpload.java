package com.ymjt.commons;

import com.ymjt.entity.UploadAttachmentResult;
import com.ymjt.entity.UploadImageResult;
import com.ymjt.utils.IDS;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class FileUpload {
    private static Logger logger = Logger.getLogger(FileUpload.class);

    public static UploadImageResult uploadImage(HttpServletRequest request) throws Exception {
        DiskFileItemFactory itemFactory = new DiskFileItemFactory();
        ServletFileUpload fileUpload = new ServletFileUpload(itemFactory);
        fileUpload.setHeaderEncoding("UTF-8");
        UploadImageResult result = new UploadImageResult();
        if (fileUpload.isMultipartContent(request)) {
            File dir = new File(request.getServletContext().getRealPath("/static/file/attachment/"));
            if (!dir.exists())
                dir.mkdirs();
            result.setErrno(0);
            List<FileItem> items = fileUpload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    continue;
                } else {
                    String suffix = item.getName().substring(item.getName().indexOf(".") + 1);
                    String fileName = IDS.getId() + "." + suffix;
                    File file = new File(dir, fileName);
                    InputStream in = item.getInputStream();
                    FileOutputStream out = new FileOutputStream(file);
                    try {
                        byte[] buffer = new byte[1024];
                        int len = -1;
                        while((len = in.read(buffer)) != -1)
                            out.write(buffer, 0, len);
                        result.getData().add(request.getServletContext().getContextPath() + "/static/file/attachment/" + fileName);
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    } finally {
                        out.close();
                        in.close();
                    }
                }
            }
        } else {
            result.setErrno(-1);
        }
        return result;
    }

    public static UploadAttachmentResult uploadAttachment(HttpServletRequest request) throws FileUploadException, IOException {
        DiskFileItemFactory itemFactory = new DiskFileItemFactory();
        ServletFileUpload fileUpload = new ServletFileUpload(itemFactory);
        fileUpload.setHeaderEncoding("UTF-8");
        UploadAttachmentResult result = new UploadAttachmentResult();
        if (fileUpload.isMultipartContent(request)) {
            File dir = new File(request.getServletContext().getRealPath("/static/file/attachment/"));
            if (!dir.exists())
                dir.mkdirs();
            List<FileItem> items = fileUpload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    continue;
                } else {
                    String suffix = item.getName().substring(item.getName().indexOf(".") + 1);
                    String rid = IDS.getId();
                    result.setRid(rid);
                    String fileName = IDS.getId() + "." + suffix;
                    File file = new File(dir, fileName);
                    InputStream in = item.getInputStream();
                    FileOutputStream out = new FileOutputStream(file);
                    try {
                        byte[] buffer = new byte[1024];
                        int len = -1;
                        while((len = in.read(buffer)) != -1)
                            out.write(buffer, 0, len);
                        result.setUrl(request.getServletContext().getContextPath() + "/static/file/attachment/" + fileName);
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    } finally {
                        out.close();
                        in.close();
                    }
                }
            }
        }
        return result;
    }
}
