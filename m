From: Charles <c@catcons.co.uk>
Date: Fri, 02 Dec 2011 09:51:46 +0000
Subject: Re: [lm-sensors] How to get patches and build with them?
Message-Id: <4ED89CE2.6070103@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4ED7B66A.6030009@catcons.co.uk>
In-Reply-To: <4ED7B66A.6030009@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/12/11 12:51, Jean Delvare wrote:
>> After installing to /usr/local the following symlink was required to
>> > allow GKrellM to start:
>> > 
>> > ln -s /usr/local/lib/libsensors.so.4 /usr/lib64/libsensors.so.4
> This can probably be avoided by passing LIBDIR=/usr/local/lib64 to
> make, and adding /usr/local/lib64 to /etc/ld.so.conf if it's not
> already there. Alternatively, just adding /usr/local/lib
> to /etc/ld.so.conf should work too.

Thanks for the advice, Jean :)

The advantage of the symlink technique is that it replaces the
lm_sensors libsensors.so.4 as installed by Slackware so, if the 3.3.1
installation is every replaced by a Slackware package, the available
libsensors.so.4 will automatically be changed.

BTW I forgot to mention that the dos2unix step was unnecessary because
patch strips the DOS-isms.

Best

Charles

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
