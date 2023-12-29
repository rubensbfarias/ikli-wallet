# Documentação da API

## Endpoints

### 1. Sign In

- **Método:** POST
- **Rota:** `/api/signin`
- **Precisa de Autenticação**: Não
- **Dados**: email (string) password (string)
- **Retorno**:
```json
{
    "user": {
        "id": 1,
        "email": "youremail@gmail.com"
    },
    "balance": "1761.00",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.gP5gP1gzwBcdYLzoxwxMgJptzcXFGj1jwdSEi4je0rU"
}
```

### 2. Carteira 

- **Método:** GET
- **Rota:** `/api/wallet/:userid`
- **Precisa de Autenticação**: Sim
- **Dados**: userid (int)
- **Retorno**:
```json
{
    {
      "user_id": 1,
      "balance": 1858.0
    }
}

```

### 3. Transações

- **Método:** GET
- **Rota:** `/api/transactions`
- **Precisa de Autenticação**: Sim
- **Dados**: userid (int) date? (date) `--opcional`
- **Retorno**:
```json
{
    "user_id": 1,
    "transactions": [
        {
            "id": 40,
            "date": "2023-12-29T02:28:34.715Z",
            "type_transaction": "credito",
            "idwallet": 1,
            "amount": 1356.0
        },
    ]
}
```

### 4. Debitar

- **Método:** PUT
- **Rota:** `/api/debit/wallet/:userid`
- **Precisa de Autenticação**: Sim
- **Dados**: userid (int) amount (float)
- **Retorno**:
```json
{
    "user_id": 1,
    "new_balance": 1857.0,
    "transaction": {
        "id": 50,
        "date": "2023-12-29T07:19:27.024Z",
        "type_transaction": "debito",
        "idwallet": 1,
        "amount": 1.0
    },
    "message": "Valor debitado com sucesso"
}
```

### 5. Creditar

- **Método:** PUT
- **Rota:** `/api/credit/wallet/:userid`
- **Precisa de Autenticação**: Sim
- **Dados**: userid (int) amount (float)
- **Retorno**:
```json
{
    "user_id": 1,
    "new_balance": 1857.0,
    "transaction": {
        "id": 50,
        "date": "2023-12-29T07:19:27.024Z",
        "type_transaction": "credito",
        "idwallet": 1,
        "amount": 1.0
    },
    "message": "Valor creditado com sucesso"
}
```
