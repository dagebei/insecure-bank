package com.example.dao;

import java.util.List;

import com.example.bean.Account;

public interface AccountDao {

	List<Account> findUsersByUsernameAndPassword(String username, String password);

	List<Account> findUsersByUsername(String username);

	List<Account> findAllUsers();

}
