package com.example.dao;

import java.util.List;

import com.example.bean.CashAccount;

public interface CashAccountDao {

	List<CashAccount> findCashAccountsByUsername(String username);

	double getFromAccountActualAmount(String fromAccount);

	void updateCashAccount(String fromAccount, double amountTotal);

	int getIdFromNumber(String fromAccount);

}
