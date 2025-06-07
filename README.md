# AWS High Availability Infrastructure with Terraform

Este proyecto despliega una infraestructura de alta disponibilidad en AWS utilizando Terraform, con Auto Scaling Group, Application Load Balancer, y monitorización completa con CloudWatch y Systems Manager.

## 🏗️ Arquitectura

La infraestructura desplegada incluye:

- **VPC** con subnets públicas y privadas en múltiples AZs
- **Application Load Balancer** en subnets públicas
- **Auto Scaling Group** con instancias EC2 en subnets privadas
- **NAT Gateways** para conectividad de salida desde subnets privadas
- **S3 Bucket** para almacenamiento
- **CloudWatch Agent** para monitorización de métricas personalizadas
- **Systems Manager (SSM)** para gestión remota de instancias
- **Security Groups** con reglas de seguridad específicas

## 📋 Prerrequisitos

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configurado
- Credenciales de AWS con permisos adecuados
- Clave SSH para acceso a instancias (opcional, SSM disponible)

## 🚀 Uso

### 1. Clonar el repositorio

```bash
git clone https://github.com/FranckyCastell/High-Availability-Architecture
cd High-Availability-Architecture
```

### 3. Desplegar la infraestructura

```bash
# Inicializar Terraform
terraform init

# Revisar el plan de ejecución
terraform plan

# Aplicar los cambios
terraform apply
```

### 4. Verificar el despliegue

Una vez completado el despliegue:

- Las instancias aparecerán en **AWS Systems Manager Fleet Manager**
- Podrás conectarte vía **Session Manager** sin SSH
- Las métricas estarán disponibles en **CloudWatch** bajo el namespace `CWAgent`
- El Load Balancer estará disponible en la URL mostrada en los outputs

## 📊 Monitorización

### CloudWatch Agent

El CloudWatch Agent está configurado para recopilar:

- **CPU**: Utilización por estado (idle, iowait, user, system)
- **Memoria**: Porcentaje de memoria utilizada
- **Disco**: Porcentaje de uso del disco

Las métricas se envían cada 60 segundos al namespace `CWAgent`.

### Systems Manager

Funcionalidades disponibles:

- **Session Manager**: Conexión segura a instancias sin SSH
- **Run Command**: Ejecutar comandos en múltiples instancias
- **Patch Manager**: Gestión de actualizaciones
- **Parameter Store**: Almacenamiento de configuraciones

## 🔧 Configuración Avanzada

### Personalizar métricas de CloudWatch

Edita el archivo `templates/userdata.tpl` para modificar la configuración del CloudWatch Agent:

```json
{
    "metrics": {
        "namespace": "MiApp/EC2",
        "metrics_collected": {
            "cpu": {
                "measurement": ["cpu_usage_idle", "cpu_usage_user"],
                "metrics_collection_interval": 300
            }
        }
    }
}
```

### Habilitar HTTPS

Para habilitar HTTPS en el ALB, agrega un certificado SSL:

```hcl
listeners = {
  ex-https = {
    port            = 443
    protocol        = "HTTPS"
    certificate_arn = "arn:aws:acm:region:account:certificate/cert-id"
    forward = {
      target_group_key = "target_groups_01"
    }
  }
}
```

## 🧹 Limpieza

Para destruir toda la infraestructura:

```bash
terraform destroy
```

**Nota**: Si encuentras errores durante la destrucción relacionados con deletion protection o dependencias, ejecuta:

```bash
# Destruir recursos en orden específico
terraform destroy -target=aws_autoscaling_attachment.asg_attachment -auto-approve
terraform destroy -target=module.asg -auto-approve
terraform destroy -target=module.alb -auto-approve
terraform destroy -auto-approve
```

## 📁 Estructura del Proyecto

```
.
├── main.tf               # Configuración principal
├── variables.tf          # Definición de variables
├── outputs.tf            # Outputs del despliegue
├── terraform.tfvars      # Valores de variables
├── templates/
│   └── userdata.tpl      # Script de inicialización de instancias
└── README.md             # Este archivo
```

## 🔐 Seguridad

- Las instancias están en subnets privadas sin acceso directo desde internet
- El tráfico web pasa a través del ALB con security groups restrictivos
- SSM permite acceso seguro sin exponer SSH
- Los buckets S3 tienen ACL privada y versionado habilitado
- Metadata service v2 (IMDSv2) requerido en instancias EC2

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## 🆘 Soporte

Si encuentras algún problema o tienes preguntas:

1. Revisa los [Issues](https://github.com/FranckyCastell/High-Availability-Architecture/issues) existentes
2. Crea un nuevo Issue con detalles del problema
3. Incluye logs de Terraform y configuración (sin credenciales)

---

**Desarrollado con ❤️ y Terraform**