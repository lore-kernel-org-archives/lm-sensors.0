From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Feb 2008 07:56:29 +0000
Subject: Re: [lm-sensors] PATCH: sensors-detect: run chip_special_cases()
Message-Id: <20080212085629.1844966c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B04B89.7090705@hhs.nl>
In-Reply-To: <47B04B89.7090705@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 11 Feb 2008 14:20:09 +0100, Hans de Goede wrote:
> The attached patch modifies sensors-detect to run chip_special_cases() earlier 
> so that the special chips get added to the modules_supported list.
> 
> Without this sensors-detect would wrongly complain that fscher is not a sensor 
> chip when run on a system with an fscher chip and the fscher driver already loaded.
> 
> If I don't get any objections I will be committing this to svn in a couple of days.

Good catch, please commit. Don't forget to commit to both active
branches of lm-sensors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
