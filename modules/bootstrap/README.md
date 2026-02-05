<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">

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
selectel_domain_name = "ID пользователя my.selectel"
selectel_username    = "username аранее готового сервисного пользователя"
selectel_password    = "SUPER_SECRET_PASSWORD от сервисного пользователя"
selectel_auth_region = "Дефолтный регион: ru-7"
provider_auth_url    = "https://cloud.api.selcloud.ru/identity/v3/"

# Project & Service User
project_name          = "Название проекта"
service_user_name     = "Название нового сервисного пользователя для управления проектом"
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

</body>
</html>
