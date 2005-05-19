From: vdovikin@jscc.ru (Oleg I. Vdovikin)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [RFC/PATCH] lost arbitration detection for PCF8584
Message-Id: <1108806184.5216.4.camel@omnibook>
List-Id: <lm-sensors.vger.kernel.org>
References: <4216C459.1060703@usa.net>
In-Reply-To: <4216C459.1060703@usa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

  the patch is looks fine to me, except these lines:

> @@ -414,8 +452,8 @@
>  
>  static u32 pcf_func(struct i2c_adapter *adap)
>  {
> -       return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
> -              I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING; 
> +       return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
> +              I2C_FUNC_PROTOCOL_MANGLING; 
>  }
  Why you've removed I2C_FUNC_I2C?

Regards,
Oleg.

P.S. I'm currently not subscribed to the list, so please CC me.

