From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: FW: Linux Hardware Monitoring for Arima HDAMA motherboard
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E3E23AC@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E23AB@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E23AB@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

More details below

----- Original Message ----- 
From: "Vaughn Rhodes" <Vaughn.Rhodes@ArimaCorp.com>
Sent: Tuesday, October 21, 2003 5:40 PM
Subject: RE: Driver to read fantach under Linux


> John & Bob,
>
> Arima's solution for reading fan speeds (and CPU temp and voltages)
> under Linux is the open source "lm_sensors" program. Attached is the
> release version of lm_sensors for Arima's HDAMA server motherboard. It
> consists of a single file, sensors.conf, and this has been tested and
> validated on RedHat 7.3/8.0/9.0 and SuSE SLES8 for AMD64. In addition to
> this Arima-specific sensors.conf file, you will also need the following
> three files:
>
> 1) Download i2c-2.7.0.tar.gz from
> http://secure.netroedge.com/~lm78/archive/i2c-2.7.0.tar.gz
> 2) Download lm_sensors-2.7.0.tar.gz from
> http://www.lm-sensors.nu/archive/lm_sensors-2.7.0.tar.gz
> 3) Download lm_sensors-2.7.0-adm1026-14.patch from
> ftp://ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-ad
> m1026-14.patch (lm_sensors patch for the ADM1026 monitor chip written by
> Philip Pokorny from Penguin Computing)
>
> (if you have trouble downloading any of the above files, let me know and
> I'll email them to you)
>
> Please see the attached readme files for detailed installation
> instructions by operating system version.
>
> Please contact me if you encounter any problems with this.
>
> Best regards,
>
> Vaughn Rhodes
> Director of Business Development
> Arima Group, North America
> 39899 Balentine Drive, Suite 197
> Newark, CA 94560
> P: 510-687-0966 x223
> F: 510-687-0968
> vaughn.rhodes@arimacorp.com
> www.arimacorp.com
>
