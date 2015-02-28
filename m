From: Taz <rastataz@gmail.com>
Date: Sat, 28 Feb 2015 12:39:43 +0000
Subject: Re: [lm-sensors] Fancontrol memory consumption
Message-Id: <54F1B70F.5020308@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141105175729.39a88ab1@endymion.delvare>
In-Reply-To: <20141105175729.39a88ab1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Besides it looked strange, it didn't bother me enough so I stopped=20
monitoring and kind of gave it up too...
But I'll certainly give the new patch a try (and restart monitoring),=20
and give you feedback of course.

Thanks a lot !

     Taz (C=E9dric L.M.)


Le 28/02/2015 11:14, Jean Delvare a =E9crit :
> Hi Taz,
>
> On Thu, 13 Nov 2014 15:36:32 +0100, Taz wrote:
>> (sorry I just saw my reply still was in my drafts, don't know why...)
>>
>> Indeed : my current bash version is 4.3.11
>> Although I don't have line 585 in my fancontrol script
>> I can apply the the patch (lines 497 & 536 for fancontrol v0.7)
> The "patch" command can apply patch files with offsets just fine.
>
>> I also gave it a try without the wait lines and not sending to
>> background the previous
>> sleep command the wait was waiting for anyway (useless ?)
> Not sending sleep in the background reportedly caused delays or
> undesirable behavior on system suspend or shutdown on some systems. See:
> http://www.lm-sensors.org/changeset/4443/lm-sensors/branches/lm-sensors-3=
.0.0/prog/pwm/fancontrol
>
>> =3D> Mem consumption seems to be the same in all cases, we'll see in the
>> long run...
> I discussed the issue with the upstream bash maintainer, but he claims
> that the implementation is correct and required for Posix compliance.
> My own tests were confusing (sometimes I could reproduce the issue,
> sometimes not) so I couldn't reach a definitive conclusion, and
> ultimately I forgot about it / gave up on it.
>
> Meanwhile someone contributed a trick to the healthd script which may
> work just fine here too. It avoids both the call to an external command
> and the use of wait. Can you please revert the previous patch and give
> a try to this one instead?
>
> ---
>   prog/pwm/fancontrol |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> --- lm-sensors.orig/prog/pwm/fancontrol	2014-11-17 09:16:14.657054963 +01=
00
> +++ lm-sensors/prog/pwm/fancontrol	2015-02-28 11:03:32.958562604 +0100
> @@ -545,8 +545,7 @@ function UpdateFanSpeeds
>   		  then # if fan was stopped start it using a safe value
>   		  	echo $minsa > $pwmo
>   			# Sleep while still handling signals
> -			sleep 1 &
> -			wait $!
> +			read -t 1 -N 0
>   		  fi
>   		fi
>   		echo $pwmval > $pwmo # write new value to pwm output
> @@ -584,6 +583,5 @@ while true
>   do
>   	UpdateFanSpeeds
>   	# Sleep while still handling signals
> -	sleep $INTERVAL &
> -	wait $!
> +	read -t $INTERVAL -N 0
>   done
>
> Thanks,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
