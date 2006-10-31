From: i.pilcher@comcast.net (Ian Pilcher)
Date: Tue, 31 Oct 2006 18:29:26 +0000
Subject: [lm-sensors] "Built-in" via686a sensors names
Message-Id: <45479606.1070006@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4545A129.5000600@comcast.net>
In-Reply-To: <4545A129.5000600@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> This is a bug in Fedora and/or gkrellm. What do you expect from us by
> reporting it on the lm_sensors list?

I guess it would be a bug in gkrellm, since it's making the assumption
that a voltage sensor will be named "inX".  OTOH, I'm not really sure
what else an application is supposed to do, since there doesn't appear
to be an API to determine the type of a sensor.

Mostly, I wanted to start a discussion about whether the current
behavior is useful.  From what you say about 2.11.0, it sounds like the
problems it causes have been recognized, which is good news.

Thanks!

-- 
====================================
Ian Pilcher                                        i.pilcher at comcast.net
====================================

