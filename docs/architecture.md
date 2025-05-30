# 🚀 Warehouse Microservices Architecture

## 🧱 Overview

A Ruby on Rails + PostgreSQL microservice system designed to simulate real-world warehouse inventory behavior. Built as a scalable, modular portfolio project.

## 🔌 Microservices

### 1. 📦 products-service

* Rails API-only service
* Stores product info: `id`, `name`, `sku`, `category`, `price_cents`, `available`
* Seeds 10,000 fake products
* Exposes RESTful endpoints to fetch products

### 2. 🔁 transactions-service

* Rails API-only service
* Records stock movements (in/out)
* Fields: `product_id`, `quantity`, `direction`, `source`
* Indexed on `product_id`
* Exposes `POST /transactions`
* Notifies `stock-service` via HTTP after each transaction
* Uses `Faraday` with retry and timeout logic

### 3. 📊 stock-service

* Rails API-only service
* Connects to same DB (or replica)
* Exposes `GET /stock_summary`
* Uses PostgreSQL materialized view (`stock_summaries`)
* Model is read-only (`StockSummary`)
* Refresh logic handled by `RefreshStockSummaryJob`
* Sidekiq used for background jobs
* `sidekiq-scheduler` used to auto-refresh every 5 minutes
* Accepts manual refresh via `POST /refresh_stock_summary`

## 🔁 Communication

* Services talk via HTTP using `Faraday`
* Example: `transactions-service` → triggers → `stock-service`
* Fallbacks and retries are in place for reliability

## 🧰 Tools and Patterns

* PostgreSQL features: indexing, materialized views
* Sidekiq + Redis for background jobs
* Auto-refresh logic runs every 5 mins via `sidekiq-scheduler`
* Code-first, scalable, production-ready microservice layout

## 🐳 Next Steps (Planned)

* Add `docker-compose.yml` for running all services together
* Share Redis container across all services
* Healthcheck endpoints for each service
* Optional: switch to event-driven pub/sub (Redis or Kafka)
