# 🤯 rails-warehouse-microservices

> A warehouse backend project no one asked for... but we built it anyway. One cup of coffee turned into three services, a Sidekiq addiction, and a client request that was supposed to be "just a dashboard." Because who needs peace of mind when you can have Sidekiq, Redis, PostgreSQL, and three Rails APIs arguing over stock levels at 3AM? 👷‍♂️📦💥

---

## 📦 What Is This?

A totally-overengineered microservice-based warehouse inventory system built with Ruby on Rails and PostgreSQL. This project was designed to:

* Show off microservice skills without deploying to the moon
* Stress test your local machine with Docker containers
* Make recruiters go: "Wait, you built what now?"

## 🧰 Tech Stack

> Stack chosen because I lost a bet with myself, and now I'm committed.

* Ruby on Rails 8 (API-only x3)
* PostgreSQL (because SQLite said “I’m full”)
* Sidekiq + Redis (background job gossip network)
* Docker + docker-compose (run everything, break everything)
* Faraday (HTTP magic spells between services)

## 🏗 Services

### 1. `products-service` 🎁

* Seeds 10,000 fake products
* RESTful API for product info
* Pretends to be useful while holding SKUs

### 2. `transactions-service` 🛒

* Logs stock movement (in/out)
* Calls `stock-service` like a clingy ex after every update
* Retries if `stock-service` ghosted

### 3. `stock-service` 📊

* Reads from a materialized view because raw SQL is too mainstream
* Sidekiq auto-refreshes stock every 5 minutes because sleep is for the weak
* Gives you `/stock_summary`, not stock advice

## 📦 How To Run It (Locally, Not in Space)

1. Clone the repo:

   ```bash
   git clone https://github.com/yourusername/rails-warehouse-microservices.git
   cd rails-warehouse-microservices
   ```

2. Boot the chaos:

   ```bash
   docker-compose up --build
   ```

3. Create DBs:

   ```bash
   docker-compose run products-service rails db:create db:migrate db:seed
   docker-compose run transactions-service rails db:create db:migrate db:seed
   docker-compose run stock-service rails db:migrate
   ```

4. Test endpoints:

   * `GET http://localhost:3001/products`
   * `POST http://localhost:3003/transactions`
   * `GET http://localhost:3002/stock_summary`

## 🛠 PostgreSQL Client Preset

You can connect to the shared PostgreSQL service from any DB client (like PgAdmin, TablePlus, or RubyMine (I use RubyMine, cause I have a lot of space on my 13inch screen):

| Field    | Value                 |
| -------- | --------------------- |
| Host     | `localhost`           |
| Port     | `5432`                |
| Username | `postgres`            |
| Password | `password`            |
| DB Name  | See below per service |

### Databases:

* `products_service_development`
* `transactions_service_development`

Each service uses its own DB. `stock-service` reads from `transactions_service_development`.

## 🧪 How It Works

* `transactions-service` sends stock changes
* `stock-service` auto-refreshes materialized view via Sidekiq
* `products-service` quietly stares into the void, waiting to be queried

## 🧱 Project Structure

```
rails-warehouse-microservices/
├── products-service/
├── transactions-service/
├── stock-service/
├── docs/
│   ├── architecture.md
├── docker-compose.yml
└── README.md ← you are here
```

## 🔥 Why You Might Love This

* Learn how real APIs argue with each other
* Build a fault-tolerant system that still panics on `docker-compose down`
* Turn PostgreSQL into a reporting engine (on purpose)

## 🧠 Bonus Features

* Retries with Faraday if `stock-service` takes a nap
* Sidekiq auto-refresh every 5 minutes (like a goldfish memory reset)
* Materialized views for speed (aka SQL cheat codes)

## ⚙️ Future Plans

* Health check endpoints (to prove we’re still alive)
* Kafka or pub/sub for real-time drama
* CI/CD pipelines (Continuous Induced Chaos & Deployment)
* Optional frontend to click buttons and feel powerful

---

## 🙃 Author

Built by a developer who thought: “Why build one Rails app when you can build three and make them talk to each other awkwardly?”

> Rustam — your friendly full stack developer with way too many Sidekiq tabs open.

---

## 📬 Contact

Feel free to reach out if you actually want to use this in production. Or if you're just impressed I made PostgreSQL cry.

---

## 🧼 License

MIT — reuse, break, blame yourself.
