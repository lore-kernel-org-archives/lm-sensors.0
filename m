From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: userspace  dev-interface linux-2.6.7
Message-Id: <20050505105738.729420cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42775670.5070709@inf.ed.ac.uk>
In-Reply-To: <42775670.5070709@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> that helps indeed, thanks very much.
> why is this not mentioned in
> linux-2.6.x/Documentation/i2c/dev-interface ?
> 
> while it is mentioned in
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/applications

No idea, most probably because nobody updated the dev-interface document
since the i2c-dev header file was split. If you submit a patch updating
it, I'll review it and have it applied.

Thanks,
-- 
Jean Delvare
