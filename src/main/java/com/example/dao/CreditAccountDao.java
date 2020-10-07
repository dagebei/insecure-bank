package com.example.dao;

import java.util.List;

import com.example.bean.CreditAccount;

public interface CreditAccountDao {

	List<CreditAccount> findCreditAccountsByUsername(String username);

	void updateCreditAccount(int cashAccountId, double round);

}
