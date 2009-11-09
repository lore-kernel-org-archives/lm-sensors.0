From: "jack" <jackchiwin@gmail.com>
Date: Mon, 09 Nov 2009 03:48:29 +0000
Subject: [lm-sensors] I2C reading problem
Message-Id: <45693B18E2174BEDA8540537C6ABD525@p431>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7961588363167674058=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============7961588363167674058==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0017_01CA6132.9576F260"

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01CA6132.9576F260
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear all,

           Why I cannot read data form i2c? while in interrupt handler
function. The "printk" output is always 0. Could anybody tell me how to fix
me code for correctly reading the data send by i2c.

#include <linux/kernel.h>

#include <linux/module.h>

#include <linux/init.h>

#include <linux/i2c.h>

#include <linux/input.h>

#include <linux/delay.h>

#include <linux/clk.h>

#include <linux/gpio.h>

#include <asm/io.h>

#include "../../../arch/arm/mach-mx51/crm_regs.h"

#include "../../../arch/arm/mach-mx51/iomux.h"

 

#define ABC_I2C_ADDR         0x03

#define I2C_DEV_NAME         "i2c-0"

#define ABC_DD_NAME         "abc_dd"

 

struct abc_dd_priv {

       struct i2c_client *client;

       struct input_dev *input;

       int irq;

};

 

static irqreturn_t abc_event_handler(int irq, void *dev_id){

           int i;

           u_int8_t dd_data[10]={0};

           struct abc_dd_priv *priv = dev_id;    

           memset(dd_data, 0, sizeof(dd_data));

           i2c_master_recv(priv->client,dd_data,sizeof(dd_data));

           for(i=0;i<10;i++){

                     printk(KERN_INFO "dd_data[%d]=%d\n",i,dd_data[i]);

           }

           return IRQ_HANDLED;

}

/* -------------------------------------------------------------------------
*/

 

static int abc_i2c_probe(struct i2c_client *client, const struct
i2c_device_id *id){

 

           struct input_dev *abc_inputdev;

           struct abc_dd_priv *priv;

  unsigned long tmp;

           int retval;

  int res;

 

           priv = kzalloc(sizeof(struct abc_dd_priv), GFP_KERNEL);

        if (!priv) {

                dev_err(&client->dev, "failed to allocate driver data\n");

                return -ENOMEM;

        }

 

           i2c_set_clientdata(client, priv);

           priv->client = client;

           priv->irq = client->irq;

 

           if(priv->irq){

                     tmp=readl(MXC_CCM_CWDR);

                     writel(tmp|0x00000008, MXC_CCM_CWDR);

                     res=mxc_request_iomux(MX51_PIN_GPIO1_5,
IOMUX_CONFIG_ALT0);

                     gpio_config(0,5,false,GPIO_INT_HIGH_LEV);

 
gpio_request_irq(0,5,GPIO_LOW_PRIO,abc_event_handler,0,ABC_DD_NAME,priv);

           }         

 

           abc_inputdev = input_allocate_device();

           if (!abc_inputdev) {

                     printk(KERN_ERR "not enough memory for input
device\n");

                     return -ENOMEM;

           }

           priv->input = abc_inputdev;

           input_set_drvdata(abc_inputdev,priv);

  abc_inputdev->name = ABC_DD_NAME;

 

           retval = input_register_device(priv->input);

  if (retval < 0) {

                     input_free_device(abc_inputdev);

                     return retval;

           }

           return 0;

}

 

static const struct i2c_device_id abc_dd_id[] = {

        { "abc_dd", 0 },

        { }

};

 

MODULE_DEVICE_TABLE(i2c, abc_dd_id);

 

static struct i2c_driver abc_driver = {

        .driver = {

                   .name    = ABC_DD_NAME,

                                    .owner           = THIS_MODULE,

                   },

        .probe = abc_i2c_probe,

                 .id_table = abc_dd_id, 

};

 

/*

 * module load/unload record keeping

 */

 

static int __init abc_dd_init(void)

{

           printk(KERN_INFO "Diver Initiating...\n");

           return i2c_add_driver(&abc_driver);

}

 

static void __exit abc_dd_exit(void)

{

           i2c_del_driver(&abc_driver);

}

 

MODULE_AUTHOR("ABC International Inc.");

MODULE_DESCRIPTION("DD driver");

MODULE_LICENSE("GPL");

 

module_init(abc_dd_init);

module_exit(abc_dd_exit);


------=_NextPart_000_0017_01CA6132.9576F260
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chmetcnv"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-TW link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Dear all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Why I cannot read data form i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>?
while in interrupt handler function. The &#8220;printk&#8221; output is =
always
0. Could anybody tell me how to fix me code for correctly reading the =
data send
by i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include =
&lt;linux/kernel.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include =
&lt;linux/module.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include =
&lt;linux/init.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include &lt;linux/i<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"2" =
UnitName=3D"C"
w:st=3D"on">2c</st1:chmetcnv>.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include =
&lt;linux/input.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include =
&lt;linux/delay.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include =
&lt;linux/clk.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include =
&lt;linux/gpio.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include =
&lt;asm/io.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include
&quot;../../../arch/arm/mach-mx51/crm_regs.h&quot;<o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#include =
&quot;../../../arch/arm/mach-mx51/iomux.h&quot;<o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#define ABC_I<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2C</st1:chmetcnv>_ADDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
0x03<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#define I<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2C</st1:chmetcnv>_DEV_NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
&quot;i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>-0&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#define
ABC_DD_NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;abc_dd&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>struct abc_dd_priv =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
i<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"2"
UnitName=3D"C" w:st=3D"on">2c</st1:chmetcnv>_client =
*client;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
input_dev
*input;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
irq;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>static irqreturn_t abc_event_handler(int irq, =
void
*dev_id){<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
int i;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
u_int8_t dd_data[10]=3D{0};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
struct abc_dd_priv *priv =3D dev_id;&nbsp;&nbsp;&nbsp; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
memset(dd_data, 0, sizeof(dd_data));<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>_master_recv(priv-&gt;client,dd_data,sizeof(=
dd_data));<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
for(i=3D0;i&lt;10;i++){<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printk(KERN_INFO =
&quot;dd_data[%d]=3D%d\n&quot;,i,dd_data[i]);<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
return IRQ_HANDLED;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>/*
-------------------------------------------------------------------------=
 */<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>static int abc_i<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>_probe(struct
i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"2" UnitName=3D"C" w:st=3D"on">2c</st1:chmetcnv>_client =
*client, const
struct i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"2" UnitName=3D"C" w:st=3D"on">2c</st1:chmetcnv>_device_id =
*id){<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
struct input_dev *abc_inputdev;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
struct abc_dd_priv *priv;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; unsigned long =
tmp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
int retval;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; int res;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
priv =3D kzalloc(sizeof(struct abc_dd_priv), =
GFP_KERNEL);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!priv)
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dev_err(&amp;client-&gt;dev, &quot;failed to allocate driver =
data\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return -ENOMEM;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>_set_clientdata(client,
priv);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
priv-&gt;client =3D client;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
priv-&gt;irq =3D client-&gt;irq;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
if(priv-&gt;irq){<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
tmp=3Dreadl(MXC_CCM_CWDR);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
writel(tmp|0x00000008, MXC_CCM_CWDR);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
res=3Dmxc_request_iomux(MX51_PIN_GPIO1_5, =
IOMUX_CONFIG_ALT0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
gpio_config(0,5,false,GPIO_INT_HIGH_LEV);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
gpio_request_irq(0,5,GPIO_LOW_PRIO,abc_event_handler,0,ABC_DD_NAME,priv);=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
abc_inputdev =3D input_allocate_device();<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
if (!abc_inputdev) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printk(KERN_ERR &quot;not enough memory for input =
device\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return -ENOMEM;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
priv-&gt;input =3D abc_inputdev;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
input_set_drvdata(abc_inputdev,priv);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; abc_inputdev-&gt;name =3D =
ABC_DD_NAME;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
retval =3D =
input_register_device(priv-&gt;input);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; if (retval &lt; 0) =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
input_free_device(abc_inputdev);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return retval;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
return 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>static const struct i<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"2" =
UnitName=3D"C"
w:st=3D"on">2c</st1:chmetcnv>_device_id abc_dd_id[] =3D =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {
&quot;abc_dd&quot;, 0 },<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { =
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>MODULE_DEVICE_TABLE(i<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"2" =
UnitName=3D"C"
w:st=3D"on">2c</st1:chmetcnv>, abc_dd_id);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>static struct i<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>_driver
abc_driver =3D {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.driver =3D {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.name&nbsp;&nbsp;&nbsp; =3D ABC_DD_NAME,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
.owner&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D
THIS_MODULE,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
},<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.probe =3D
abc_i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>_probe,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .id_table =3D abc_dd_id, =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>/*<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;* module load/unload record =
keeping<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;*/<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>static int __init =
abc_dd_init(void)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
printk(KERN_INFO &quot;Diver =
Initiating...\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
return i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>_add_driver(&amp;abc_driver);<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>static void __exit =
abc_dd_exit(void)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
i<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">2c</st1:chmetcnv>_del_driver(&amp;abc_driver);<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>MODULE_AUTHOR(&quot;ABC International =
Inc.&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>MODULE_DESCRIPTION(&quot;DD =
driver&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>MODULE_LICENSE(&quot;GPL&quot;);<o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>module_init(abc_dd_init);<o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>module_exit(abc_dd_exit);<o:p></o:p></span></fon=
t></p>

</div>

</body>

</html>

------=_NextPart_000_0017_01CA6132.9576F260--



--===============7961588363167674058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7961588363167674058==--

