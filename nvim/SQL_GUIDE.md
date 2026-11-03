# 🗄️ SQL Development in Neovim (`vim-dadbod` & `DBUI`)

This setup is equipped with a modern, high-performance database IDE built directly into Neovim using:
* **`tpope/vim-dadbod`**: The core asynchronous database engine.
* **`kristijanhusak/vim-dadbod-ui`**: Visual database drawer / explorer.
* **`kristijanhusak/vim-dadbod-completion`** + **`blink.cmp`**: Lightning-fast intelligent autocompletion for SQL keywords, database tables, column names, and table aliases.
* **`nvim-treesitter`**: Full SQL syntax highlighting and query structure understanding.

---

## 📁 How to Manually Create a Database in a Targeted Folder

When using SQLite, a database is a single file ending in `.db`. To place your database in a specific folder (like `/home/navi/Documents/sql`), follow either of these methods:

> [!IMPORTANT]
> **The Full Path Rule**:
> * If you write only `sqlite:school.db`, SQLite will create the file in whichever folder Neovim was launched from (often your home directory `~`).
> * **Always use the absolute full path** to target your exact folder:  
>   `sqlite:/home/navi/Documents/sql/school.db`

---

### Method 1: Doing it 100% Inside Neovim (Using DBUI)

1. **Open Neovim and the Database Explorer**:
   ```bash
   nvim /home/navi/Documents/sql/practice.sql
   ```
   Type `:DBUI` to open the sidebar.

2. **Open the Connection Prompt**:
   In the DBUI sidebar, press:
   ```text
   Shift + A    (or type :DBUIAddConnection)
   ```

3. **Enter the Full Path Connection URL**:
   When the popup asks **`Enter connection url`**, type the full path:
   ```text
   sqlite:/home/navi/Documents/sql/school.db
   ```
   Press `<Enter>`.

4. **Enter the Connection Name**:
   When it asks **`Enter name (optional)`**, type:
   ```text
   school
   ```
   Press `<Enter>`.

5. **Write Your First Query to Save the File to Disk**:
   SQLite is "lazy" and does **not** create the physical file on disk until your first table is created:
   In your SQL buffer, type:
   ```sql
   CREATE TABLE students (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       name TEXT NOT NULL,
       grade INTEGER
   );

   INSERT INTO students (name, grade) VALUES ('Alex', 10);
   ```
   Highlight the lines in Visual mode (`V`) and press:
   ```text
   <Space>r
   ```
   Choose **`school`** if prompted.

The file `/home/navi/Documents/sql/school.db` is now physically created in your targeted folder and visible in your file tree!

---

### Method 2: Creating it via the Linux Terminal (CLI)

If you prefer to create the database file before opening Neovim:

1. **Navigate to your targeted folder**:
   ```bash
   cd /home/navi/Documents/sql
   ```

2. **Create and open the database with the `sqlite3` CLI**:
   ```bash
   sqlite3 school.db
   ```

3. **Create a table and exit**:
   ```sql
   CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);
   .exit
   ```
   *(Your file `/home/navi/Documents/sql/school.db` is now saved on disk!)*

4. **Connect it in Neovim**:
   Open Neovim and run `:DBUI`. Press `Shift + A`, then type:
   * URL: `sqlite:/home/navi/Documents/sql/school.db`
   * Name: `school`

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
| `Shift + A` (or `A`) | **Add Connection**: Prompt for URL & name |
| `d` | **Delete Connection**: Remove saved connection from drawer |
| `Shift + R` (or `R`) | **Redraw / Refresh**: Reload all databases, schemas, and tables |
| `r` | **Rename**: Rename connection or query buffer |
| `H` | Toggle table schema details |
| `q` | **Close** the DBUI drawer |

---

### 🗄️ Managing Multiple Databases
You can have **unlimited databases** (e.g. `dev`, `school`, `ecommerce`, `mysql_local`) connected at the same time:
* All connected databases appear listed one below another in the DBUI sidebar.
* Press `o` or `<Enter>` to expand or collapse any database.
* To delete an old or unwanted connection, move your cursor to it in DBUI and press **`d`**.

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

### 1. SQLite (Local File in Targeted Folder)
```text
sqlite:/home/navi/Documents/sql/my_database.db
```

### 2. MySQL / MariaDB (Local or Remote)
```text
mysql://username:password@localhost:3306/my_database
```

### 3. PostgreSQL
```text
postgresql://username:password@localhost:5432/my_database
```
*(With SSL / options)*:
```text
postgresql://username:password@aws-endpoint.rds.amazonaws.com:5432/prod?sslmode=require
```

### 4. DuckDB (Analytical & In-Process)
```text
duckdb:/home/navi/Documents/sql/analytics.duckdb
```

### 5. Microsoft SQL Server (MSSQL)
```text
sqlserver://username:password@localhost:1433?database=my_database
```

---

## 📌 Pro-Tips for Daily SQL Work

### 1. Set a Default Database for a Single File
If you have multiple databases and want a specific SQL script to always execute against one without prompting, add this comment at the very top of your `.sql` file:
```sql
-- conn: sqlite:/home/navi/Documents/sql/school.db
SELECT * FROM students;
```
Or in Neovim normal mode, set it for the buffer:
```vim
:let b:db = 'sqlite:/home/navi/Documents/sql/school.db'
```

### 2. Pre-configured Databases
Your local databases can also be pre-configured in `~/Dotfiles/nvim/lua/plugins/sql.lua` using `vim.g.dbs`:
```lua
vim.g.dbs = {
  { name = "dev", url = "sqlite:/home/navi/Documents/sql/dev.db" },
  { name = "school", url = "sqlite:/home/navi/Documents/sql/school.db" },
}
```

### 3. Query History & Saved Queries
`vim-dadbod-ui` automatically saves your query history and custom queries in `~/.local/share/db_ui`.
* In the DBUI drawer, open the **`Saved queries`** or **`Query history`** fold to re-run past queries with a single keystroke.

### 4. Export Results
When query results appear in the preview split:
* You can select and yank text (`y`) as normal.
* You can save the output buffer to a text or markdown file using `:w results.txt`.
