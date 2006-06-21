From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 21 Jun 2006 15:10:38 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <4dfa50520606210810ha9d426au499cf2dbce454781@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Rudolf,

On 6/20/06, Jean Delvare <khali at linux-fr.org> wrote:
> This initialization doesn't make much sense, it is arbitrary and the
> value will be overwritten on first update anyway. What's the purpose?

The value can't be zero, so I initialized it to 1. This is also a
holdover from emulating 0 (disabled). Let's take it out and test it
that way. What do you think, Rudolf?

David

