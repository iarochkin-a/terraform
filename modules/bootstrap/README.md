<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<title>Terraform Bootstrap Module (Selectel)</title>
<style>
  body {
    font-family: 'Helvetica Neue', Arial, sans-serif;
    max-width: 1000px;
    margin: 0 auto;
    padding: 30px;
    background-color: #f9f9f9;
    color: #333;
    line-height: 1.6;
  }
  h1, h2, h3 {
    color: #2c3e50;
  }
  h1 {
    font-size: 2em;
  }
  h2 {
    font-size: 1.6em;
    border-bottom: 2px solid #3498db;
    padding-bottom: 5px;
  }
  h3 {
    font-size: 1.3em;
    margin-top: 20px;
    color: #2980b9;
  }
  pre {
    background-color: #2d2d2d;
    color: #f8f8f2;
    padding: 15px;
    border-radius: 5px;
    overflow-x: auto;
  }
  code {
    font-family: Consolas, monospace;
    background-color: #e8e8e8;
    padding: 2px 5px;
    border-radius: 3px;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin: 15px 0;
  }
  table, th, td {
    border: 1px solid #ddd;
  }
  th, td {
    padding: 8px 12px;
  }
  th {
    background-color: #3498db;
    color: white;
  }
  ul {
    margin: 10px 0 10px 20px;
  }
  .emoji {
    font-size: 18px;
    margin-right: 6px;
  }
  .section {
    margin-bottom: 35px;
  }
  .card {
    background-color: #ecf0f1;
    padding: 15px 20px;
    border-left: 5px solid #3498db;
    margin: 15px 0;
    border-radius: 5px;
  }
  .highlight-hcl {
    color: #f1c40f;
  }
  .highlight-bash {
    color: #2ecc71;
  }
</style>
</head>
<body>

<h1>🌐 Terraform Bootstrap Module (Selectel)</h1>

<div class="section">
<p>Модуль <strong>bootstrap</strong> предназначен для <strong>инициализации базовой инфраструктуры Selectel</strong> для Terraform-проекта.</p>

<p>Он создаёт:</p>
<ul>
  <li>🏗 <strong>Selectel Project</strong> — отдельный проект в облаке, под которым разворачивается вся инфраструктура.</li>
  <li>👤 <strong>Service User</strong> — сервисный пользователь Terraform, используемый для управления ресурсами.</li>
</ul>

<p>Модуль полностью изолирован и используется как <strong>первичный root module</strong>. После его применения можно безопасно создавать остальные модули (network, compute, S3 и т.д.), не затрагивая root пользователя или сам проект.</p>
</div>

<div class="section">
<h2>📁 Структура модуля</h2>
<pre>
modules/bootstrap/
├── main.tf        # Ресурсы Selectel: project и service user
├── variables.tf   # Переменные модуля
├── outputs.tf     # Выходные значения: project_id, service_user_name, service_user_password
└── versions.tf    # Требуемый provider selectel
</pre>
</div>

<div class="section">
<h2>⚙️ Переменные</h2>

<h3>1️⃣ Selectel authentication</h3>
<div class="card">
<pre><span class="highlight-hcl">selectel_domain_name = "ваш Selectel Account ID"
selectel_username    = "имя заранее созданного пользователя в панели my.selectel"
selectel_password    = "пароль сервисного пользователя"
selectel_auth_region = "регион, например ru-7"
provider_auth_url    = "https://cloud.api.selcloud.ru/identity/v3/"</span></pre>
</div>
<p>Эти переменные нужны для авторизации Terraform в Selectel API.</p>

<h3>2️⃣ Selectel project и service user</h3>
<div class="card">
<pre><span class="highlight-hcl">project_name           = "имя создаваемого проекта"
service_user_name      = "имя сервисного пользователя Terraform"
service_user_password  = "пароль сервисного пользователя"</span></pre>
</div>
<ul>
  <li><strong>project_name</strong> — название нового проекта, под которым будет работать Terraform.</li>
  <li><strong>service_user_name</strong> — сервисный пользователь для управления ресурсами внутри проекта.</li>
  <li><strong>service_user_password</strong> — пароль для сервисного пользователя.</li>
</ul>
<p>🔒 Рекомендуется использовать <strong>длинные и сложные пароли</strong>, сервисный пользователь должен иметь права только внутри созданного проекта.</p>
</div>

<div class="section">
<h2>📤 Outputs</h2>
<table>
<tr>
<th>Output</th>
<th>Описание</th>
</tr>
<tr>
<td>project_id</td>
<td>ID созданного Selectel проекта</td>
</tr>
<tr>
<td>service_user_name</td>
<td>Имя сервисного пользователя</td>
</tr>
<tr>
<td>service_user_password</td>
<td>Пароль сервисного пользователя (sensitive)</td>
</tr>
</table>
</div>

<div class="section">
<h2>🚀 Quickstart</h2>

<h3>1️⃣ Создайте файл <code>bootstrap/terraform.tfvars</code>:</h3>
<div class="card">
<pre><span class="highlight-hcl"># Selectel credentials
selectel_domain_name = "1234567"
selectel_username    = "terraform-root"
selectel_password    = "SUPER_SECRET_PASSWORD"
selectel_auth_region = "ru-3"
provider_auth_url    = "https://cloud.api.selcloud.ru/identity/v3/"

# Project & Service User
project_name          = "terraform-prod"
service_user_name     = "terraform-sa"
service_user_password = "VERY_STRONG_20+_PASSWORD"</span></pre>
</div>

<h3>2️⃣ Подключите модуль в <code>bootstrap/main.tf</code>:</h3>
<div class="card">
<pre><span class="highlight-hcl">module "bootstrap" {
  source = "../modules/bootstrap"

  project_name          = var.project_name
  service_user_name     = var.service_user_name
  service_user_password = var.service_user_password
}</span></pre>
</div>

<h3>3️⃣ Инициализация и создание проекта:</h3>
<div class="card">
<pre><span class="highlight-bash">cd bootstrap
terraform init
terraform plan
terraform apply</span></pre>
</div>

<h3>4️⃣ Получение output:</h3>
<div class="card">
<pre><span class="highlight-bash">terraform output</span></pre>
</div>
<ul>
  <li><code>project_id</code> — ID нового проекта</li>
  <li><code>service_user_name</code> — имя сервисного пользователя</li>
  <li><code>service_user_password</code> — пароль сервисного пользователя</li>
</ul>
</div>

<div class="section">
<h2>⚡ Рекомендации</h2>
<ul>
  <li>Используйте отдельного сервисного пользователя для Terraform, не root.</li>
  <li>Не храните <code>tfvars</code> с секретами в Git; лучше использовать Vault или environment variables.</li>
  <li>Bootstrap создаётся один раз и изолирован. Все последующие ресурсы создаются через service user.</li>
  <li>Рекомендуется сразу подключить <strong>remote state</strong> (например, Selectel S3) после bootstrap.</li>
</ul>
</div>

</body>
</html>
