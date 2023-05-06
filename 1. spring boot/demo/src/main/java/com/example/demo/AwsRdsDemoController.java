package com.example.demo;

import com.amazonaws.services.s3.AmazonS3;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/aws/rds")
public class AwsRdsDemoController {

    @Autowired
    private AmazonS3 amazonS3;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @PostMapping("/insert")
    public void insert(@RequestParam String nome, @RequestParam String fabricante){

        this.jdbcTemplate.update("insert into dbo.produto (nome, fabricante) values (?, ?)", nome, fabricante);
    }

    @GetMapping("/select")
    public String select(){

        StringBuilder sb = new StringBuilder();

        String query = "SELECT * FROM dbo.produto";

        this.jdbcTemplate.query(query, rs -> {

            while (rs.next()) {

                sb.append(rs.getString("nome") + " - " + rs.getString("fabricante")).append("\n");
            }
        });

        return sb.toString();
    }
}
