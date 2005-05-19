From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Fancontrol (perl) patch
Message-Id: <40D49838.2090608@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
In-Reply-To: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

applied
thanks

Dean Takemori wrote:
> 
> 
> Add END {} block to restore fans on many kinds of errors/interrupts.
> Remove arugment from restorefans
> 
> 
> 
> --- lm_sensors-2.8.7/prog/pwm/fancontrol  2004-06-14 22:12:52.000000000 
> -1000
> +++ lm_sensors-2.8.7/prog/pwm/fancontrol-patched  2004-06-14 
> 22:11:31.000000000 -1000
> @@ -73,6 +73,8 @@
>  sub calc(@);
>  sub UpdateFanSpeeds();
> 
> +END { restorefans(); }
> +
>  our $opt_d;
>  getopts('d');
> 
> @@ -294,8 +296,6 @@
>  ################################################################ 
> restorefans()
>  sub restorefans()
>  {
> -  my $sigtype = shift;
> -
>    $SIG{TERM} = 'IGNORE';
>    $SIG{HUP}  = 'IGNORE';
>    $SIG{INT}  = 'IGNORE';
> 
> 
