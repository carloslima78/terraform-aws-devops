package com.demo.s3;

import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@RestController
@RequestMapping("/aws/s3")
public class DemoS3Controller {

    @Autowired
    private AmazonS3 amazonS3;

    @GetMapping("/listbuckets")
    public String listBuckets(){

        StringBuilder bucketNames = new StringBuilder();

        try {
            var buckets = this.amazonS3.listBuckets();

            for (Bucket bucket : buckets) {
                bucketNames.append(bucket.getName()).append("\n");
            }

        }
        catch (AmazonServiceException ase) {
            System.out.println("Erro no serviço da AWS: " + ase.getMessage());
        }
        catch (AmazonClientException ace) {
            System.out.println("Erro no cliente da AWS: " + ace.getMessage());
        }

        return bucketNames.toString();
    }

    // Gera um Objeto (Arquivo .txt), escreve um texto e armazena no Bucket S3.
    @PostMapping("/writefile")
    public void writeFile(@RequestParam String bucket, @RequestParam String arquivo, @RequestParam String conteudoArquivo){

        try {
            this.amazonS3.putObject(bucket, arquivo + " .txt", conteudoArquivo);

        }
        catch (AmazonServiceException ase) {
            System.out.println("Erro no serviço da AWS: " + ase.getMessage());
        }
        catch (AmazonClientException ace) {
            System.out.println("Erro no cliente da AWS: " + ace.getMessage());
        }
    }

    @PostMapping("/upload")
    public void upload(@RequestParam String pasta, @RequestParam String bucket, @RequestParam String key){

        try {
            File file = new File(pasta);
            this.amazonS3.putObject(new PutObjectRequest(bucket, key, file));

        }
        catch (AmazonServiceException ase) {
            System.out.println("Erro no serviço da AWS: " + ase.getMessage());
        }
        catch (AmazonClientException ace) {
            System.out.println("Erro no cliente da AWS: " + ace.getMessage());
        }
    }

    @PostMapping("/download")
    public void download(@RequestParam String pasta, @RequestParam String bucket, @RequestParam String key){

        try {
            S3Object s3Object = this.amazonS3.getObject(new GetObjectRequest(bucket, key));
            File file = new File(pasta);
            s3Object.getObjectContent().transferTo( new FileOutputStream(file));
        }
        catch (AmazonServiceException ase) {
            System.out.println("Erro no serviço da AWS: " + ase.getMessage());
        }
        catch (AmazonClientException ace) {
            System.out.println("Erro no cliente da AWS: " + ace.getMessage());
        }
        catch (IOException ioe) {
            System.out.println("Erro ao salvar o arquivo localmente: " + ioe.getMessage());
        }
    }
}
