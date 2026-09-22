import pandas as pd
import numpy as np

# 1. 读取数据
file_path = 'data/WA_Fn-UseC_-HR-Employee-Attrition.csv'
df = pd.read_csv(file_path)

# 2. 查看基本信息
print("=== 数据基本信息 ===")
print(df.info())
print("\n=== 缺失值检查 ===")
print(df.isnull().sum())

# 3. 数据清洗与转换
# 把 Attrition 和 OverTime 的 Yes/No 转成 1/0
df['Attrition'] = df['Attrition'].apply(lambda x: 1 if x == 'Yes' else 0)
df['OverTime'] = df['OverTime'].apply(lambda x: 1 if x == 'Yes' else 0)

# 4. 剔除无用的列（EmployeeCount, Over18, StandardHours 全是单值，MonthlyRate 无意义）
drop_cols = ['EmployeeCount', 'Over18', 'StandardHours', 'MonthlyRate']
df = df.drop(columns=drop_cols)

# 5. 新增计算列（为看板做维度切分）
# 司龄分段
df['TenureGroup'] = pd.cut(df['YearsAtCompany'], bins=[-1, 1, 3, 5, 10, 40],
                           labels=['0-1年', '1-3年', '3-5年', '5-10年', '10年以上'])
# 月薪分段
df['IncomeBand'] = pd.cut(df['MonthlyIncome'], bins=[0, 3000, 6000, 10000, 20000],
                          labels=['3k以下', '3k-6k', '6k-10k', '10k以上'])

# 6. 导出清洗后的数据到 data 文件夹
output_path = 'data/dwd_hr_employee_detail.csv'
df.to_csv(output_path, index=False)
print(f"\n✅ 数据清洗完成！已导出至：{output_path}")
print(f"清洗后的数据维度：{df.shape}")