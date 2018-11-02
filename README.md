# Pagos automáticos

Este proyecto muestra cómo recibir pagos con [PayU](https://www.payulatam.com/) e [ePayco](https://epayco.co/).

## Requisitos

Para ejecutar este proyecto localmente necesitas tener instalado:

* Ruby
* PostgreSQL
* Una cuenta en [PayU](https://www.payulatam.com/) y/o en [ePayco](https://epayco.co/)

Clona el proyecto:

```
git clone https://github.com/makeitrealcamp/ejemplo-pagos.git
```

Crea un archivo `config/application.yml` con el siguiente contenido. Reemplaza los valoes con la que obtengas de tu cuenta en PayU e ePayco:

```yml
PAYU_MERCHANT_ID: "..."
PAYU_ACCOUNT_ID: "..."
PAYU_API_KEY: "..."

EPAYCO_KEY: "..."
# Este valor se llama en ePayco P_KEY (no confundir con PRIVATE_KEY)
EPAYCO_SECRET: "..."

HOSTNAME: localhost:3000
```

Si vas a desplegar en Heroku debes crear estas variables de entorno en la configuración de la cuenta o utilizando `heroku config`.

Instala las dependencias:

```
bundle
```

Crea la base de datos y carga el esquema:

```
rails db:create & rails db:schema:load
```

Eso es todo. Localmente no se van a actualizar los pagos con el resultado, sólo cuando publiques la aplicación en Internet.
