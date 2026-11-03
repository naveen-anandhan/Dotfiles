# 🗄️ SQL Development in Neovim (`vim-dadbod` & `DBUI`)

This setup is equipped with a modern, high-performance database IDE built directly into Neovim using:
* **`tpope/vim-dadbod`**: The core asynchronous database engine.
* **`kristijanhusak/vim-dadbod-ui`**: Visual database drawer / explorer.
* **`kristijanhusak/vim-dadbod-completion`** + **`blink.cmp`**: Lightning-fast intelligent autocompletion for SQL keywords, database tables, column names, and table aliases.
* **`nvim-treesitter`**: Full SQL syntax highlighting and query structure understanding.

---

## ⚡ Quick Start: Your First SQL Query in 60 Seconds

You can start writing and running SQL immediately using a local **SQLite** database (zero server setup required).

### Step 1: Open a SQL file
Open any `.sql` file in Neovim:
```bash
nvim ~/Documents/sql/practice.sql
```

### Step 2: Open Database Explorer (`:DBUI`)
Type in normal mode:
```vim
:DBUI
```
A sidebar will appear on the left.

### Step 3: Add a Connection
1. In the DBUI drawer, press **`a`** (Add connection).
2. For **Connection URL**, type:
   ```text
   sqlite:my_database.db
   ```
3. For **Connection Name**, type:
   ```text
   LocalSQLite
   ```
4. Press `<Enter>`. Your database is now connected and listed in the drawer!

### Step 4: Write Some SQL
In your SQL buffer, type:
```sql
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    role TEXT DEFAULT 'developer'
);

INSERT INTO users (name, email, role) VALUES 
('Alice', 'alice@example.com', 'admin'),
('Bob', 'bob@example.com', 'developer'),
('Charlie', 'charlie@example.com', 'designer');

SELECT * FROM users WHERE role = 'developer';
```

### Step 5: Execute Queries (`<Space>r`)
* **Run Entire File**: In normal mode, press:
  ```text
  <leader>r    (or <Space>r)
  ```
* **Run Selected Query Only**: Highlight the lines you want to run using Visual mode (`V`), then press:
  ```text
  <leader>r    (or <Space>r)
  ```
A result split window will immediately appear showing the formatted table output!

---

## 🧭 Keybindings & Workflow

### 🚀 Query Execution
| Shortcut | Mode | Action |
| :--- | :--- | :--- |
| `<leader>r` (or `<Space>r`) | **Normal** | Run all queries in the current SQL file |
| `<leader>r` (or `<Space>r`) | **Visual** | Run only the highlighted query / lines |
| `:DB` | Command | Run current buffer or range against default connection |

---

### 📂 DBUI Sidebar Controls
Open the database explorer anytime with `:DBUI` or `:DBUIToggle`.

| Key in DBUI Drawer | Action |
| :--- | :--- |
| `o` or `<Enter>` | Expand / Collapse database or table |
| `o` on a Table | **Preview Table**: Opens top 200 rows in a split |
| `S` or `K` | **New Query**: Opens a new scratch query buffer for this DB |
| `r` | **Refresh**: Reload schemas, tables, and columns |
| `a` | **Add Connection**: Prompt for URL & name |
| `d` | **Delete Connection**: Remove saved connection from drawer |
| `H` | Toggle table schema details |
| `q` | **Close** the DBUI drawer |

---

### 💡 Intelligent SQL Autocompletion (`blink.cmp`)
Your setup includes contextual SQL autocomplete. While typing in any `.sql` buffer:

1. **Table Suggestions**: When typing `FROM ` or `JOIN `, `blink.cmp` automatically suggests available tables in your database.
2. **Column Suggestions**: When typing `SELECT ` or `WHERE `, column names for active tables pop up.
3. **Table Aliases**: If you write `FROM users u WHERE u.`, typing `.` triggers completion for all columns belonging to `users`!
4. **Completion Keys**:
   * `<Tab>`: Accept completion suggestion.
   * `<Ctrl + j>`: Navigate down the suggestion list.
   * `<Ctrl + k>`: Navigate up the suggestion list.
   * Auto-documentation pops up beside suggestions to show column types and table definitions.

---

## 🔌 Connection URL Formats

`vim-dadbod` supports practically every popular database. Here are connection strings for common engines:

### 1. SQLite (Local File)
```text
sqlite:database.db
sqlite:/home/navi/Documents/sql/mydb.sqlite
```

### 2. PostgreSQL
```text
postgresql://user:password@localhost:5432/my_database
```
*(With SSL / options)*:
```text
postgresql://user:password@aws-endpoint.rds.amazonaws.com:5432/prod?sslmode=require
```

### 3. MySQL / MariaDB
```text
mysql://user:password@localhost:3306/my_database
```

### 4. DuckDB (Analytical & In-Process)
```text
duckdb:analytics.duckdb
```

### 5. Microsoft SQL Server (MSSQL)
```text
sqlserver://user:password@localhost:1433?database=my_database
```

### 6. Redis
```text
redis://127.0.0.1:6379/0
```

---

## 📌 Pro-Tips for Daily SQL Work

### 1. Set a Default Database for a Single File
If you have multiple databases and want a specific SQL script to always execute against one without prompting, add this comment at the very top of your `.sql` file:
```sql
-- conn: sqlite:my_database.db
SELECT * FROM users;
```
Or in Neovim normal mode, set it for the buffer:
```vim
:let b:db = 'sqlite:my_database.db'
```

### 2. Query History & Saved Queries
`vim-dadbod-ui` automatically saves your query history and custom queries in `~/.local/share/db_ui`.
* In the DBUI drawer, open the **`Saved queries`** or **`Query history`** fold to re-run past queries with a single keystroke.

### 3. Export Results
When query results appear in the preview split:
* You can select and yank text (`y`) as normal.
* You can save the output buffer to a text or markdown file using `:w results.txt`.

### 4. Clean Syntax Highlighting
SQL keywords, strings, functions, numbers, and operators are color-coded using `nvim-treesitter` in sync with your active Neovim color theme (`gruvbox`).
