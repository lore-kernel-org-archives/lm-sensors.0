From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: RFC lmsensors sysfs interface documentation
Message-Id: <253818670503281427229d1866@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9kug41tbmj5kp8bmadk4t7bupgvnl15q0m@4ax.com>
In-Reply-To: <9kug41tbmj5kp8bmadk4t7bupgvnl15q0m@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Note that bmcsensors also creates    
"[in|temp|fan|curr][1-100]_label"     sysfs entries which are
undocumented - I decided to add them in the original port so that the
label information accessible through the ipmi SDR entries would be
easily accessible (and could potentially be used by lm_sensors and
other userland utils automatically).

Yani

On Tue, 29 Mar 2005 07:53:35 +1000, Grant Coady
<grant_nospam@dodo.com.au> wrote:
> Hi All,
> 
> I've started a little documentation project here:
> 
>   http://scatter.mine.nu/lmsensors/sysfs-names/
> 
> So far I generated list of sysfs interface names, culled the
> documented ones and produced a second list.
> 
> I don't know if anyone has a cross-reference which driver uses
> what name but I'm thinking of producing one, perhaps a table,
> X = drivers, Y = sysfs names, * marks the spot?  This been done?
> 
> Worth doing?
> 
> Comments, suggestions welcome.
> 
> Cheers,
> Grant.
> 
>
