From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Mar 2014 20:59:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Do not accept name attributes which include '-'
Message-Id: <20140302215958.18f24207@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 02 Mar 2014 08:29:11 -0800, Guenter Roeck wrote:
> On 03/02/2014 08:24 AM, Guenter Roeck wrote:
> > On 03/02/2014 05:17 AM, Jean Delvare wrote:
> >> I like it, thanks for doing that. Maybe we could check for spaces too?
> >> That would break libsensors as well, and I vaguely recalled that
> >> someone attempted that once already (caught during code review,
> >> thankfully.)
> >
> > Makes sense. Any other invalid characters we should look out for
> > since we are at it ?
> 
> Newline, '\', '?', '*' comes into mind, and possibly quotes (single
> and double).

FWIW I don't think libsensors would mind about quotes or '?'. It would
certainly be bothered by '*' because it is used as a wildcard when
matching chips names. Newlines would be an issue with sscanf probably.
'\' shouldn't matter unless it triggers a bug.

Now, except for newline, I don't really expect anyone to include any of
thee in a chip name, and I don't recall it ever happening. Newline
could accidentally be added at the end of the name, but that wouldn't
matter because libsensors only reads the first line from the file IIRC.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
