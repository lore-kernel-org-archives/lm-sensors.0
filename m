From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: mandrake issues
Message-Id: <Pine.LNX.4.58.0406142229360.20062@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040614122901.4625.qmail@web80306.mail.yahoo.com>
In-Reply-To: <20040614122901.4625.qmail@web80306.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

> I am using kernel 2.6.3-7mdk

Thanks.

> and i keep receiving the following error druing the
> (make user_install) stage
>
> install: cannot create regular file
> `/etc/sensors.conf': Permission denied
> make: *** [install-etc] Error 1

Its because you need to be root or "administrator" to write to this
directory.

I found for you more suitable solution. Mandrake has this lm_sensor
package already ready for you!

Just try to install

http://rpms.mandrakeclub.com/rpms/MandrakeClub/test/10.0/i586/lm_sensors-2.8.6-0.1mdk.i586.html

package called  like lm_sensors-2.8.6-0.1mdk.i586

After that run command: sensors-detect

It will create automatically config for your configuration
and save it here /etc/sysconfig/lm_sensors

It will work after reboot or after you issue this command:
/etc/init.d/lm_sensors start

If it will write Permission denied use command su to get root.

like this:
ruik@kiur:~$ su
Password:
kiur:/home/ruik# /etc/init.d/lm_sensors start

After that run command:
sensors

to see the output. Or install some GUI aplication like gkrellm to get some
graphical representation. Try to find some suitable application
in mandrake packages yourself. I'm using that gkrellm.

I hope this helps. Because nor I or any other developer uses mandrake
and this package,  please try to contact people from mandrake if any
futher troubles with this package. (or find some mandrake mailing list or
web forum) I know only what I have written here :)

Regards

Rudolf
