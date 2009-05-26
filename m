From: Hector Oron <hector.oron@gmail.com>
Date: Tue, 26 May 2009 19:20:00 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <dd0a3d700905261220q729c3f15lf21728b84b6570@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

  Nelson Castillo's contribution was missing, those were the missing
bits, hence the warning,
[PATCH 2/2] s3c-adc: Expose number of remaining conversions to convert
callback[1]

BTW, do you know any user application I can use to test the driver?

Cheers =3D)

[1] http://marc.info/?l=3Dlinux-arm-kernel&m=124250942823013&w=3D2

--

 arch/arm/plat-s3c/include/plat/adc.h |    3 ++-
 arch/arm/plat-s3c24xx/adc.c          |   11 +++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/adc.h
b/arch/arm/plat-s3c/include/plat/adc.h
index 43df2a4..a3e34b7 100644
--- a/arch/arm/plat-s3c/include/plat/adc.h
+++ b/arch/arm/plat-s3c/include/plat/adc.h
@@ -21,7 +21,8 @@ extern int s3c_adc_start(struct s3c_adc_client *client,

 extern struct s3c_adc_client *s3c_adc_register(struct platform_device *pde=
v,
 					       void (*select)(unsigned selected),
-					       void (*conv)(unsigned d0, unsigned d1),
+					       void (*conv)(unsigned d0, unsigned d1,
+					       unsigned *samples_left),
 					       unsigned int is_ts);

 extern void s3c_adc_release(struct s3c_adc_client *client);
diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c24xx/adc.c
index 9a5c767..0613eed 100644
--- a/arch/arm/plat-s3c24xx/adc.c
+++ b/arch/arm/plat-s3c24xx/adc.c
@@ -45,7 +45,8 @@ struct s3c_adc_client {
 	unsigned char		 channel;

 	void	(*select_cb)(unsigned selected);
-	void	(*convert_cb)(unsigned val1, unsigned val2);
+	void	(*convert_cb)(unsigned val1, unsigned val2,
+                                unsigned *samples_left);
 };

 struct adc_device {
@@ -158,7 +159,8 @@ static void s3c_adc_default_select(unsigned select)

 struct s3c_adc_client *s3c_adc_register(struct platform_device *pdev,
 					void (*select)(unsigned int selected),
-					void (*conv)(unsigned d0, unsigned d1),
+					void (*conv)(unsigned d0, unsigned d1,
+                                        unsigned *samples_left),
 					unsigned int is_ts)
 {
 	struct s3c_adc_client *client;
@@ -210,9 +212,10 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 	data1 =3D readl(adc->regs + S3C2410_ADCDAT1);
 	adc_dbg(adc, "read %d: 0x%04x, 0x%04x\n", client->nr_samples, data0, data=
1);

-	(client->convert_cb)(data0 & 0x3ff, data1 & 0x3ff);
+	client->nr_samples--;
+	(client->convert_cb)(data0 & 0x3ff, data1 & 0x3ff, &client->nr_samples);

-	if (--client->nr_samples > 0) {
+	if (client->nr_samples > 0) {
 		/* fire another conversion for this */

 		client->select_cb(1);
--=20
1.6.3.1

--=20
 H=E9ctor Or=F3n

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
