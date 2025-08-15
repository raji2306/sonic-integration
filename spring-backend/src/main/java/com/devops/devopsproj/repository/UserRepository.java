package com.devops.devopsproj.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.devops.devopsproj.model.User;

public interface UserRepository extends JpaRepository <User,Long>{

}
