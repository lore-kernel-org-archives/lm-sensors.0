From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 19 Oct 2005 20:19:30 +0000
Subject: [lm-sensors] feedback request: i2c bus and v4l driver for
Message-Id: <20051019201813.33d1dbae.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
In-Reply-To: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Szymon,

> Perhaps my request is not as usual as others. I have written an
> experimental i2c driver for my radio card which is basically
> bit-banging i2c bus controlling radio chips on board. I would
> like to ask you just to take a look at my code. I would be
> greateful for any remarks.

Please submit your work as a unified diff against the latest -mm tree,
not a compressed tarball. This will give you a much better chance to
have someone comment on your code.

-- 
Jean Delvare
