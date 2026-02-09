## 快速开始

```bash
go run main.go -config ./etc
```

## 项目结构

```
demo-api/
├── build/              # 构建和部署配置
│   ├── docker/
│   └── k8s/
├── constants/          # 常量和配置定义
├── controller/         # 控制器层
│   └── v1/             # API 版本
│       ├── base/       # 基础控制器
│       └── hobby/      # 业务控制器
├── dao/                # 数据访问层
├── etc/                # 配置文件
├── model/              # 数据模型
│   ├── api/            # API 相关模型
│   └── idl/            # grpc 接口定义
├── service/            # 服务层
│   └── caller/         # 服务调用
├── web/                # 接口注册
├── go.mod 
├── main.go             # 项目入口
```

## IDL生成和Dao层生成
```
go generate ./...
```

## 配置管理

### 配置文件

- `etc/config.yaml` - 业务配置
- `etc/default.yaml` - 系统默认配置