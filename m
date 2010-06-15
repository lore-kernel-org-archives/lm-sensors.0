From: Juerg Haefliger <juergh@gmail.com>
Date: Tue, 15 Jun 2010 16:59:09 +0000
Subject: Re: [lm-sensors] Getting sensor information from HP ProLiant DL360
Message-Id: <AANLkTinPjoxHoK2EAML5y_jn_TZsWuER8iN3MBTJx7Tm@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C178641.2050903@fischer.name>
In-Reply-To: <4C178641.2050903@fischer.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Markus,

For HP servers, use the hplog tool that is part of the hp-health
package which you can get from hp.com.

...juerg


C100231:~# hplog -f -t
ID     TYPE        LOCATION      STATUS  REDUNDANT FAN SPEED
 1  Var. Speed   System Board    Normal     Yes     Low    ( 13)
 2  Var. Speed   System Board    Normal     Yes     Low    ( 13)
 3  Var. Speed   System Board    Normal     Yes     Low    ( 29)
 4  Var. Speed   System Board    Normal     Yes     Low    ( 29)
 5  Var. Speed   System Board    Normal     Yes     Low    ( 29)
 6  Var. Speed   System Board    Normal     Yes     Low    ( 29)

ID     TYPE        LOCATION      STATUS    CURRENT  THRESHOLD
 1  Basic Sensor Ambient         Normal    75F/ 24C 138F/ 59C
 2  Basic Sensor CPU (1)         Normal   104F/ 40C 179F/ 82C
 3  Basic Sensor CPU (2)         Normal   ---F/---C 179F/ 82C
 4  Basic Sensor Memory Board    Normal    86F/ 30C 188F/ 87C
 5  Basic Sensor Memory Board    Normal    84F/ 29C 188F/ 87C
 6  Basic Sensor Memory Board    Normal   ---F/---C 188F/ 87C
 7  Basic Sensor Memory Board    Normal   ---F/---C 188F/ 87C
 8  Basic Sensor Pwr. Supply Bay Normal   105F/ 41C 194F/ 90C
 9  Basic Sensor Pwr. Supply Bay Normal    93F/ 34C 149F/ 65C
10  Basic Sensor I/O Zone        Normal   105F/ 41C 194F/ 90C
11  Basic Sensor I/O Zone        Normal    87F/ 31C 158F/ 70C
12  Basic Sensor I/O Zone        Normal    95F/ 35C 194F/ 90C
13  Basic Sensor I/O Zone        Normal    86F/ 30C 167F/ 75C
14  Basic Sensor I/O Zone        Normal    98F/ 37C 167F/ 75C
15  Basic Sensor I/O Zone        Normal    95F/ 35C 167F/ 75C
16  Basic Sensor I/O Zone        Normal    77F/ 25C 158F/ 70C
17  Basic Sensor I/O Zone        Normal    80F/ 27C 158F/ 70C
18  Basic Sensor I/O Zone        Normal    80F/ 27C 158F/ 70C
19  Basic Sensor Processor Zone  Normal    73F/ 23C 158F/ 70C
20  Basic Sensor Processor Zone  Normal    84F/ 29C 158F/ 70C
21  Basic Sensor Processor Zone  Normal    87F/ 31C 176F/ 80C
22  Basic Sensor Processor Zone  Normal    84F/ 29C 176F/ 80C
23  Basic Sensor I/O Zone        Normal   100F/ 38C 176F/ 80C
24  Basic Sensor Memory Board    Normal    82F/ 28C 158F/ 70C
25  Basic Sensor Memory Board    Normal    86F/ 30C 158F/ 70C
26  Basic Sensor Memory Board    Normal    84F/ 29C 158F/ 70C
27  Basic Sensor I/O Zone        Normal    93F/ 34C 158F/ 70C
28  Basic Sensor I/O Zone        Normal    80F/ 27C 158F/ 70C
29  Basic Sensor System Board    Normal    73F/ 23C 149F/ 65C
30  Basic Sensor I/O Zone        Normal   145F/ 63C 230F/110C


On Tue, Jun 15, 2010 at 3:55 PM, Markus Fischer <markus@fischer.name> wrote:
> Hi,
>
> our new machine arrived today and I'd like to get as much information out of
> it as possible. I'm using Debian Lenny with a 2.6.26-2-vserver-amd64 kernel,
> arch is x86_64 .
>
> I've installed lm-sensors (sensors --version reports sensors version 3.0.2
> with libsensors version 3.0.2 , package is 1:3.0.2-1+b2 ) and ran
> "sensors-detect"; attached is the output.
>
> "sensors" only reports one information for me:
>
> $ sudo sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +8.3°C  (crit = +31.3°C)
>
> I'm missing other temps, fans, CPU, etc. and I'm wondering how I could
> improve the situtation; I couldn't find out much what the current status of
> lm-sensors support for my machine is. I looked at
> http://lm-sensors.org/wiki/Devices and only found one reference to HP
> stating:
>
> "
>  SMSC   SCH4307         yes                             (2010-02-11) Super
> I/O with hardware monitoring capabilities. Used in HP servers. Datasheets
> only available under NDA, no driver yet."
>
> I guess it applies to me, but I'm not sure?
>
> "sensors" suggests to load the module "ipmisensors", I search turned up
> http://bmcsensors-26.sourceforge.net/ for the 2.6 kernels. However, the
> patch available from
> https://sourceforge.net/project/showfiles.php?group_id4509&package_id9597
> (link for ">=2.6.17" kernels) does not apply, and the other link
> "impisensors-experimental" to
> http://bmcsensors-26.sourceforge.net/ipmisensors/ doesn't work.
>
> Are there any other options?
>
> thanks,
> - Markus
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
