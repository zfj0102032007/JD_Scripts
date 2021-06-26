## Version: v3.41.0
## Date: 2021-06-13
## Update Content: 重新加入AutoHelpOther参数，但是部分人启用后并不生效，默认false自行按照自身情况修改为true。（配置文件不会自动智能替换，需要手动进入面板通过对比工具手动替换）

## 上面版本号中，如果第2位数字有变化，那么代表增加了新的参数，如果只有第3位数字有变化，仅代表更新了注释，没有增加新的参数，可更新可不更新

################################## 说明 ##################################
## 以下配置中，带有 export 申明的，均由lxk0301大佬定义，其他互助码，考虑到直接按lxk0301大佬定义的变量去填的话，一是不方便记忆，二是容易搞混，所以最终的变量将由脚本去组合，你只要按注释去填即可
## 除此之外，还额外增加了是否自动删除失效任务AutoDelCron、是否自动增加新任务AutoAddCron、删除旧日志时间RmLogDaysAgo、随机延迟启动任务RandomDelay、是否添加自定义脚本EnableExtraShell五个人性化的设置供选择
## 所有赋值等号两边不能有空格，所有的值请一律在两侧添加半角的双引号，如果变量值中含有双引号，则外侧改为一对半角的单引号。
## 所有的赋值都可以参考 “定义jd_pet是否静默运行” 部分，在不同时间设置不同的值，以达到你想要的效果，具体判断条件如下：
## $(date "+%-d") 当前的日期，如：13
## $(date "+%-w") 当前是星期几，如：3
## $(date "+%-H") 当前的小时数，如：23
## $(date "+%-M") 当前的分钟数，如：49
## 其他date命令的更多用法，可以在命令行中输入 date --help  查看
## 判断条件 -eq -ne -gt -ge -lt -le ，具体含义可百度一下


################################## 定义Cookie（必填） ##################################
## 请依次填入每个用户的Cookie，Cookie的具体形式（只有pt_key字段和pt_pin字段，没有其他字段）：pt_key=xxxxxxxxxx;pt_pin=xxxx;
## 1. 如果是通过控制面板编辑本文件，点击页面上方“扫码获取Cookie”即可获取，此方式获取的Cookie有效期为3个月
## 2. 还可以通过浏览器开发工具获取，此方式获得的Cookie只有1个月有效期
## 必须按数字顺序1、2、3、4...依次编号下去，例子只有6个，超出6个你继续往下编号即可
## 不允许有汉字，如果ID有汉字，请在PC浏览器上获取Cookie，会自动将汉字转换为URL编码
Cookie1="pt_key=AAJgyDe6ADBSLj1FVSpuGgcrMLJLhaA-KBlj7Dj1onXP4MLvSvS8dCOhbsvOrfJSzckSgG9ULkU;pt_pin=zfj0102032007;"
## 压寨夫人 pt_key=AAJgyEgTADCusHTHSHfBeGudCHcY_LABGl91eHknMPVfzP7_cSuei7FJ9qpNwSkhRDNh1K8sJ4Q;pt_pin=wdNPrMAsxYRANVr;
Cookie2=""
## 二姐 pt_key=AAJgyXT5ADA8S3IXZ9xeM6UHwKjKD9JfOPAR_5E7oN6Xn4YeSKceQHFDuaO4IU-u6TS6IaQ6IqY;pt_pin=13825134972_p;
Cookie3=""
##自己小号 pt_key=AAJgyf53ADBkplPhk87EsopzCi_PJVp06VbOfNV_-kOhU4JK6o_j7grnBlda1-iCeKCtT5yjkbU;pt_pin=jd_IdkfLzAGvQNz;
Cookie4=""
## 吴伟 jd_V i g o s s  pt_key=AAJgydxVADCPe7WYiFnxO3w4Da4s3Wkplg918-lL5_6YWQwSVmKiaT2bV2tyggzU53iAW1rDl8I;pt_pin=298592196-187620;
Cookie5=""
## MD pt_key=AAJgyfRVADAKndA3Rm86lLCiQ-4otAdczNEOL-t9-jcm4SY_pxSEgfg7K9KDQPyEhsj4pXooL0s;pt_pin=jd_VnIoepztLJeR;
Cookie6=""


################################## 临时屏蔽某个Cookie（选填） ##################################
## 如果某些Cookie已经失效了，但暂时还没法更新，可以使用此功能在不删除该Cookie和重新修改Cookie编号的前提下，临时屏蔽掉某些编号的Cookie
## 多个Cookie编号以半角的空格分隔，两侧一对半角双引号，使用此功能后，在运行js脚本时账号编号将发生变化
## 举例1：TempBlockCookie="2"    临时屏蔽掉Cookie2
## 举例2：TempBlockCookie="2 4"  临时屏蔽掉Cookie2和Cookie4
## 如果只是想要屏蔽某个账号不玩某些小游戏，可以参考下面 case 这个命令的例子来控制，脚本名称请去掉后缀 “.js”
## case $1 in
##   jd_fruit)
##     TempBlockCookie="5"      # 账号5不玩jd_fruit
##     ;;
##   jd_dreamFactory | jd_jdfactory)
##     TempBlockCookie="2"      # 账号2不玩jd_dreamFactory和jd_jdfactory
##     ;;
##   jd_jdzz | jd_joy)
##     TempBlockCookie="3 6"    # 账号3、账号6不玩jd_jdzz和jd_joy
##     ;;
##  esac
TempBlockCookie=""


################################## 定义是否自动删除失效的脚本与定时任务（选填） ##################################
## 有的时候，某些JS脚本只在特定的时间有效，过了时间就失效了，需要自动删除失效的本地定时任务，则设置为 "true" ，否则请设置为 "false"
## 检测文件： 仓库中的 docker/crontab_list.sh
## 当设置为 "true" 时，会自动从检测文件中读取比对删除的任务（识别以“jd_”、“jr_”、“jx_”开头的任务）
## 当设置为 "true" 时，脚本只会删除一整行失效的定时任务，不会修改其他现有任务，所以任何时候，你都可以自己调整你的crontab.list
## 当设置为 "true" 时，如果你有添加额外脚本是以“jd_”“jr_”“jx_”开头的，如检测文件中，会被删除，不是以“jd_”“jr_”“jx_”开头的任务则不受影响
AutoDelCron="true"


################################## 定义是否自动增加新的本地定时任务（选填） ##################################
## 增加定时任务，如需要本地自动增加新的定时任务，则设置为 "true" ，否则请设置为 "false"
## 检测文件： 仓库中的 docker/crontab_list.sh
## 当设置为 "true" 时，如果检测到检测文件中有增加新的定时任务，那么在本地也增加（识别以“jd_”、“jr_”、“jx_”开头的任务）
## 当设置为 "true" 时，会自动从检测文件新增加的任务中读取时间，该时间为北京时间
## 当设置为 "true" 时，脚本只会增加新的定时任务，不会修改其他现有任务，所以任何时候，你都可以自己调整你的crontab.list
AutoAddCron="true"


################################## 定义删除日志的时间（选填） ##################################
## 定义在运行删除旧的日志任务时，要删除多少天以前的日志，请输入正整数，不填则禁用删除日志的功能
RmLogDaysAgo="7"


################################## 定义随机延迟启动任务（选填） ##################################
## 如果任务不是必须准点运行的任务，那么给它增加一个随机延迟，由你定义最大延迟时间，单位为秒，如 RandomDelay="300" ，表示任务将在 1-300 秒内随机延迟一个秒数，然后再运行
## 在crontab.list中，在每小时第0-2分、第30-31分、第59分这几个时间内启动的任务，均算作必须准点运行的任务，在启动这些任务时，即使你定义了RandomDelay，也将准点运行，不启用随机延迟
## 在crontab.list中，除掉每小时上述时间启动的任务外，其他任务在你定义了 RandomDelay 的情况下，一律启用随机延迟，但如果你按照Wiki教程给某些任务添加了 "now"，那么这些任务也将无视随机延迟直接启动
RandomDelay="360"


################################## 定义User-Agent（选填） ##################################
## 自定义lxk0301大佬仓库里JD系列js脚本的User-Agent，不懂不知不会User-Agent的请不要随意填写内容，随意填写了出错概不负责
## 如需使用，请自行解除下一行注释
# export JD_USER_AGENT=""


################################## 定义通知TOKEN（选填） ##################################
## 想通过什么渠道收取通知，就填入对应渠道的值
## 1. ServerChan，教程：http://sc.ftqq.com/3.version
export PUSH_KEY=""

## 2. BARK，教程（看BARK_PUSH和BARK_SOUND的说明）：https://gitee.com/lxk0301/jd_docker/blob/master/githubAction.md#%E4%B8%8B%E6%96%B9%E6%8F%90%E4%BE%9B%E4%BD%BF%E7%94%A8%E5%88%B0%E7%9A%84-secrets%E5%85%A8%E9%9B%86%E5%90%88
export BARK_PUSH=""
export BARK_SOUND=""

## 3. Telegram，如需使用，TG_BOT_TOKEN和TG_USER_ID必须同时赋值，教程：https://gitee.com/lxk0301/jd_docker/blob/master/backUp/TG_PUSH.md
export TG_BOT_TOKEN=""
export TG_USER_ID=""

## 4. 钉钉，教程（看DD_BOT_TOKEN和DD_BOT_SECRET部分）：https://gitee.com/lxk0301/jd_docker/blob/master/githubAction.md#%E4%B8%8B%E6%96%B9%E6%8F%90%E4%BE%9B%E4%BD%BF%E7%94%A8%E5%88%B0%E7%9A%84-secrets%E5%85%A8%E9%9B%86%E5%90%88
export DD_BOT_TOKEN=""
export DD_BOT_SECRET=""

## 5. iGot聚合推送，支持多方式推送，填写iGot的推送key。教程：https://wahao.github.io/Bark-MP-helper/#/
export IGOT_PUSH_KEY=""

## 6. Push Plus，微信扫码登录后一对一推送或一对多推送，参考文档：http://www.pushplus.plus
## 其中PUSH_PLUS_USER是一对多推送的“群组编码”（一对多推送下面->您的群组(如无则新建)->群组编码）注:(1、需订阅者扫描二维码 2、如果您是创建群组所属人，也需点击“查看二维码”扫描绑定，否则不能接受群组消息推送)，只填PUSH_PLUS_TOKEN默认为一对一推送
export PUSH_PLUS_TOKEN="8617e37784b043c6ae4f3bf4e9d5477d"
export PUSH_PLUS_USER=""

## 7. 企业微信机器人消息推送 webhook 后面的 key，文档：https://work.weixin.qq.com/api/doc/90000/90136/91770
export QYWX_KEY=""

## 8. 企业微信应用消息推送的值，文档：https://work.weixin.qq.com/api/doc/90000/90135/90236 
## 依次填上corpid的值,corpsecret的值,touser的值,agentid,media_id的值，注意用,号隔开，例如："wwcff56746d9adwers,B-791548lnzXBE6_BWfxdf3kSTMJr9vFEPKAbh6WERQ,mingcheng,1000001,2COXgjH2UIfERF2zxrtUOKgQ9XklUqMdGSWLBoW_lSDAdafat"
export QYWX_AM=""


################################## 定义每日签到的通知形式（选填） ##################################
## js脚本每日签到提供3种通知方式，分别为：
## 关闭通知，那么请在下方填入0
## 简洁通知，那么请在下方填入1，其效果见：https://gitee.com/lxk0301/jd_docker/blob/master/icon/bean_sign_simple.jpg
## 原始通知，那么请在下方填入2，如果不填也默认为2，内容比较长，这也是默认通知方式
NotifyBeanSign=""

################################## 定义每日签到每个接口间的延迟时间（选填） ##################################
## 默认每个签到接口并发无延迟，如需要依次进行每个接口，请自定义延迟时间，单位为毫秒，延迟作用于每个签到接口, 如填入延迟则切换顺序签到(耗时较长)
export JD_BEAN_STOP=""

################################## 自动按顺序进行账号间互助（选填） ##################################
## 设置为 true 时，以下所有互助活动，账号间将按照config.sh中Cookie顺序进行互助，此时，不会助力不在config.sh中的账号，无法和别人交换助力
## MyXxxx系列变量仍然需要填写，但ForOtherXxxx系列变量不再需要填写（填写了也无效）
## 如果启用了TempBlockCookie，那么只是被屏蔽的账号不助力其他账号，其他账号还是会助力被屏蔽的账号
AutoHelpOther=""

################################## 定义jd_zoo Pk互助（临时） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyZooPk1=""
MyZooPk2=""
MyZooPk3=""
MyZooPk4=""
MyZooPk5=""
MyZooPk6=""
MyZooPkA=""
MyZooPkB=""

ForOtherZooPk1=""
ForOtherZooPk2=""
ForOtherZooPk3=""
ForOtherZooPk4=""
ForOtherZooPk5=""
ForOtherZooPk6=""

################################## 定义jd_zoo 个人互助（临时） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyZoo1=""
MyZoo2=""
MyZoo3=""
MyZoo4=""
MyZoo5=""
MyZoo6=""
MyZooA=""
MyZooB=""

ForOtherZoo1=""
ForOtherZoo2=""
ForOtherZoo3=""
ForOtherZoo4=""
ForOtherZoo5=""
ForOtherZoo6=""

################################## 定义jd_health互助（临时） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
Myhealth1=""
Myhealth2=""
Myhealth3=""
Myhealth4=""
Myhealth5=""
Myhealth6=""
MyhealthA=""
MyhealthB=""

ForOtherhealth1=""
ForOtherhealth2=""
ForOtherhealth3=""
ForOtherhealth4=""
ForOtherhealth5=""
ForOtherhealth6=""

################################## 定义jd_fruit互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyFruit1="598e8c0306ec49309cc18f18202c691b"
MyFruit2="032db35ec0884e48898b569681e8a9e6"
MyFruit3="6308d7358a054a0d88a89b2de4d78ec8"
MyFruit4="510ce55139f1485189d6be59aeafe48c"
MyFruit5="7fa5284c80c24b81b3fe282a068bfc58"
MyFruitDing6="ad719c4eb20c44d8b24c0664c6e409bd"
MyFruitDing7="63b91181592045a78a75b3ff867c77b4"
MyFruitDing8="9d423bcc439a431584d76beb225bd645"
MyFruitDing9="6989f15eb9b3477a9e5e36defcf18887"

ForOtherFruit1="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruit4}@${MyFruit5}@${MyFruitDing6}@${MyFruitDing7}@${MyFruitDing8}@${MyFruitDing9}"
ForOtherFruit2="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruit4}@${MyFruit5}@${MyFruitDing6}@${MyFruitDing7}@${MyFruitDing8}@${MyFruitDing9}"
ForOtherFruit3="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruit4}@${MyFruit5}@${MyFruitDing6}@${MyFruitDing7}@${MyFruitDing8}@${MyFruitDing9}"
ForOtherFruit4="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruit4}@${MyFruit5}@${MyFruitDing6}@${MyFruitDing7}@${MyFruitDing8}@${MyFruitDing9}"
ForOtherFruit5=""
ForOtherFruit6=""


################################## 定义jd_pet互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyPet1="MTEzMzI1MTE4NTAwMDAwMDA1MDQyMzg2NQ=="
MyPet2=""
MyPet3=""
MyPet4=""
MyPet5=""
MyPet6=""
MyPetA=""
MyPetB=""

ForOtherPet1=""
ForOtherPet2=""
ForOtherPet3=""
ForOtherPet4=""
ForOtherPet5=""
ForOtherPet6=""


################################## 定义jd_plantBean互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyBean1="c6tcvetpcrqreyqcgwl6cuvjdbsxxsymxlvzxyy"
MyBean2="4wph7v5ym5epectua5qptxgxc5uj7tibnrcfvjy"
MyBean3="f3er4cqcqgwogsn5dxvdsdsili3h7wlwy7o5jii"
MyBean4="ncksv7cad43gnmnqjlmtt3nblcrvhd6y5qrylaa"
MyBean5="qmnmamd3ukiwqykt3horkluvnzlbpz75drbjiry"
MyBeanDing6="joinzr73z7glnhjt34rxxv5kwqbzcvuif55cjtgehbhudst3wmwq"
MyBeanDing7="tbr2sdwaqlg6ucgqshaxchecme3h7wlwy7o5jii"
MyBeanDing8="olmijoxgmjuty34trv26d6wqhtiqscv25cwmd6a"
MyBeanDing9="iu237u55hwjipg7yqwgfxjnzqraeljcffdstsai"

ForOtherBean1="${MyBean1}@${MyBean2}@${MyBean3}@${MyBean4}@${MyBean5}@${MyBeanDing6}@${MyBeanDing7}@${MyBeanDing8}@${MyBeanDing9}"
ForOtherBean2="${MyBean1}@${MyBean2}@${MyBean3}@${MyBean4}@${MyBean5}@${MyBeanDing6}@${MyBeanDing7}@${MyBeanDing8}@${MyBeanDing9}"
ForOtherBean3="${MyBean1}@${MyBean2}@${MyBean3}@${MyBean4}@${MyBean5}@${MyBeanDing6}@${MyBeanDing7}@${MyBeanDing8}@${MyBeanDing9}"
ForOtherBean4="${MyBean1}@${MyBean2}@${MyBean3}@${MyBean4}@${MyBean5}@${MyBeanDing6}@${MyBeanDing7}@${MyBeanDing8}@${MyBeanDing9}"
ForOtherBean5=""
ForOtherBean6=""


################################## 定义jd_dreamFactory互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyDreamFactory1="KRV7YuwPzZ3GSO1PJo1hBg=="
MyDreamFactory2="JfbbKD7q16zzsDtob2Iqhw=="
MyDreamFactory3="65AsUnksR8j5byk3CsG-Qw=="
MyDreamFactoryDing4="ozDh0h_t3D-IIXw0ZFq8GQ=="
MyDreamFactoryDing5="yTV6E1lfQkhkCvGqjBlR0Q=="
MyDreamFactoryDing6="uCg3FVbttlyS1ZZ7hVKtJw=="
MyDreamFactoryDing7="LPBpI-Vicgo-rj0U3IO3OWgZmr8T_CgnLqNxosjBvrU="
MyDreamFactoryB=""

ForOtherDreamFactory1="${MyDreamFactory1}@${MyDreamFactory2}@${MyDreamFactory3}@${MyDreamFactoryDing4}@${MyDreamFactoryDing5}@${MyDreamFactoryDing6}@${MyDreamFactoryDing7}"
ForOtherDreamFactory2="${MyDreamFactory1}@${MyDreamFactory2}@${MyDreamFactory3}@${MyDreamFactoryDing4}@${MyDreamFactoryDing5}@${MyDreamFactoryDing6}@${MyDreamFactoryDing7}"
ForOtherDreamFactory3="${MyDreamFactory1}@${MyDreamFactory2}@${MyDreamFactory3}@${MyDreamFactoryDing4}@${MyDreamFactoryDing5}@${MyDreamFactoryDing6}@${MyDreamFactoryDing7}"
ForOtherDreamFactory4="${MyDreamFactory1}@${MyDreamFactory2}@${MyDreamFactory3}@${MyDreamFactoryDing4}@${MyDreamFactoryDing5}@${MyDreamFactoryDing6}@${MyDreamFactoryDing7}"
ForOtherDreamFactory5=""
ForOtherDreamFactory6=""


################################## 定义jd_jdfactory互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyJdFactory1="T0189KspQB8Z91TUIhr0kwCjVWnYaS5kRrbA"
MyJdFactory2="T020-akNIFxkhBefSXiF6pFICjVWnYaS5kRrbA"
MyJdFactory3="T018v_57QhsY9lDeJxib1ACjVWnYaS5kRrbA"
MyJdFactory4="T022vPR7RRcb9F3RPRv8k_EIdACjVWnYaS5kRrbA"
MyJdFactory5="T0205KkcOUpCoyidUW2y9YlACjVWnYaS5kRrbA"
MyJdFactoryDing6="T018v_h7Qh4b9lXRJBqb1ACjVWnYaS5kRrbA"
MyJdFactoryDing7="T0225KkcRhZI8lSEdEullaYLdgCjVWnYaS5kRrbA"
MyJdFactoryDing8="T0205KkcI0lxnw23QWilz71LCjVWnYaS5kRrbA"
MyJdFactoryDing9="T032a3T3lZ64Iv9f-apmQHmFoYk5W6DzOLgjCjVWnYaS5kRrbA"

ForOtherJdFactory1="${MyJdFactory1}@${MyJdFactory2}@${MyJdFactory3}@${MyJdFactoryDing4}@${MyJdFactoryDing5}@${MyJdFactoryDing6}@${MyJdFactoryDing7}@${MyJdFactoryDing8}@${MyJdFactoryDing9}"
ForOtherJdFactory2="${MyJdFactory1}@${MyJdFactory2}@${MyJdFactory3}@${MyJdFactoryDing4}@${MyJdFactoryDing5}@${MyJdFactoryDing6}@${MyJdFactoryDing7}@${MyJdFactoryDing8}@${MyJdFactoryDing9}"
ForOtherJdFactory3="${MyJdFactory1}@${MyJdFactory2}@${MyJdFactory3}@${MyJdFactoryDing4}@${MyJdFactoryDing5}@${MyJdFactoryDing6}@${MyJdFactoryDing7}@${MyJdFactoryDing8}@${MyJdFactoryDing9}"
ForOtherJdFactory4="${MyJdFactory1}@${MyJdFactory2}@${MyJdFactory3}@${MyJdFactoryDing4}@${MyJdFactoryDing5}@${MyJdFactoryDing6}@${MyJdFactoryDing7}@${MyJdFactoryDing8}@${MyJdFactoryDing9}"
ForOtherJdFactory5=""
ForOtherJdFactory6=""


################################## 定义jd_jdzz互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyJdzz1=""
MyJdzz2=""
MyJdzz3=""
MyJdzz4=""
MyJdzz5=""
MyJdzz6=""
MyJdzzA=""
MyJdzzB=""

ForOtherJdzz1=""
ForOtherJdzz2=""
ForOtherJdzz3=""
ForOtherJdzz4=""
ForOtherJdzz5=""
ForOtherJdzz6=""


################################## 定义jd_crazy_joy互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyJoy1=""
MyJoy2=""
MyJoy3=""
MyJoy4=""
MyJoy5=""
MyJoy6=""
MyJoyA=""
MyJoyB=""

ForOtherJoy1=""
ForOtherJoy2=""
ForOtherJoy3=""
ForOtherJoy4=""
ForOtherJoy5=""
ForOtherJoy6=""


################################## 定义jd_jxnc互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
## jd_jxnc助力码为 JSON 格式因此使用单引号，json 格式如下
## {"smp":"22bdadsfaadsfadse8a","active":"jdnc_1_btorange210113_2","joinnum":"1"}
## 助力码获取可以通过 bash jd.sh jd_get_share_code now 命令获取
## 注意：jd_jxnc 种植种子发生变化的时候，互助码也会变！！
MyJxnc1=''
MyJxnc2=''
MyJxnc3=''
MyJxnc4=''
MyJxnc5=''
MyJxnc6=''
MyJxncA=''
MyJxncB=''

ForOtherJxnc1=""
ForOtherJxnc2=""
ForOtherJxnc3=""
ForOtherJxnc4=""
ForOtherJxnc5=""
ForOtherJxnc6=""

################################## 定义jd_jxnc TOKEN（选填目前主要用于cfd提现） ##################################
## 如果某个Cookie的账号种植的是app种子，则必须填入有效的TOKEN；而种植非app种子则不需要TOKEN
## TOKEN的形式：{"farm_jstoken":"749a90f871adsfads8ffda7bf3b1576760","timestamp":"1610165423873","phoneid":"42c7e3dadfadsfdsaac-18f0e4f4a0cf"}
## 因TOKEN中带有双引号，因此，变量值两侧必须由一对单引号引起来
TokenJxnc1='{"farm_jstoken":"7bb4120cfe02d73bf83128d7c4fc6d95","timestamp":"1624685979919","phoneid":"60e256d74867a631"}'
TokenJxnc2=''
TokenJxnc3=''
TokenJxnc4=''
TokenJxnc5=''
TokenJxnc6=''

################################## 定义jd_bookshop互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyBookShop1=""
MyBookShop2=""
MyBookShop3=""
MyBookShop4=""
MyBookShop5=""
MyBookShop6=""
MyBookShopA=""
MyBookShopB=""

ForOtherBookShop1=""
ForOtherBookShop2=""
ForOtherBookShop3=""
ForOtherBookShop4=""
ForOtherBookShop5=""
ForOtherBookShop6=""


################################## 定义jd_cash互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyCash1="aU1tbO2yZPwl827VzA"
MyCash2="ZE9JDK7PF79umAyktRVR"
MyCash3="Ihg_bumzZfgv9my6iw"
MyCash4="IRI_aeWwZ_Ug7G_dzHUR1g"
MyCash5="eU9YFbjpMIBsgBmTqg1Z"
MyCashDing6="Ih4_buywZf0g9W66iw"
MyCashDing7="eU9YauTjYfx1pT-EyiIS1A"
MyCashDing8="eU9YD7vaDKVGkByEkDlS"
MyCashDing9="9pKzuWwTsVeuKN5HH_2cA3qOSxKQx9l4"

ForOtherCash1="${MyCash1}@${MyCash2}@${MyCash3}@${MyCash4}@${MyCashDing5}@${MyCashDing6}@${MyCashDing7}@${MyCashDing8}@${MyCashDing9}"
ForOtherCash2="${MyCash1}@${MyCash2}@${MyCash3}@${MyCash4}@${MyCashDing5}@${MyCashDing6}@${MyCashDing7}@${MyCashDing8}@${MyCashDing9}"
ForOtherCash3="${MyCash1}@${MyCash2}@${MyCash3}@${MyCash4}@${MyCashDing5}@${MyCashDing6}@${MyCashDing7}@${MyCashDing8}@${MyCashDing9}"
ForOtherCash4="${MyCash1}@${MyCash2}@${MyCash3}@${MyCash4}@${MyCashDing5}@${MyCashDing6}@${MyCashDing7}@${MyCashDing8}@${MyCashDing9}"
ForOtherCash5="${MyCash1}@${MyCash2}@${MyCash3}@${MyCash4}@${MyCashDing5}@${MyCashDing6}@${MyCashDing7}@${MyCashDing8}@${MyCashDing9}"
ForOtherCash6=""


################################## 定义jd_sgmh互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MySgmh1=""
MySgmh2=""
MySgmh3=""
MySgmh4=""
MySgmh5=""
MySgmh6=""
MySgmhA=""
MySgmhB=""

ForOtherSgmh1=""
ForOtherSgmh2=""
ForOtherSgmh3=""
ForOtherSgmh4=""
ForOtherSgmh5=""
ForOtherSgmh6=""


################################## 定义jd_cfd活动互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyCfd1=""
MyCfd2=""
MyCfd3=""
MyCfd4=""
MyCfd5=""
MyCfd6=""
MyCfdA=""
MyCfdB=""

ForOtherCfd1=""
ForOtherCfd2=""
ForOtherCfd3=""
ForOtherCfd4=""
ForOtherCfd5=""
ForOtherCfd6=""



################################## 定义jd_try相关参数（选填） ##################################

##控制每次获取商品数量，默认12
export JD_TRY_PAGE_SIZE=""

##商品分类，以 @ 隔开，示例：家用电器@手机数码@电脑办公@家居家装
export JD_TRY_CIDS_KEYS=""

##试用类型，以 @ 隔开，示例：免费试用@闪电试
export JD_TRY_TYPE_KEYS=""

##过滤试用商品关键字，以 @ 隔开(默认内置了很多关键字，建议使用默认)
export JD_TRY_GOOD_FILTERS=""

##试用商品最低价格
export JD_TRY_MIN_PRICE=""

##试用商品最多提供数量（过滤垃圾商品）
export JD_TRY_MAX_SUPPLY_COUNT=""




################################## 定义京喜工厂开团ID（选填） ##################################
## 京喜工厂拼团瓜分电力活动的`activeId`默认读取内置的如出现脚本开团提示失败：`活动已结束，请稍后再试~`，可自行抓包替换(开启抓包，进入拼团瓜分电力页面，寻找带有`tuan`的链接里面的`activeId=`)

export TUAN_ACTIVEID=""

################################## 定义jd_super_redrain通知（选填） ##################################
## 默认开启false为关闭

export RAIN_NOTIFY_CONTROL=""

################################## 定义jd_cash京豆兑换（选填） ##################################
## jd_cash京豆兑换，花费2元红包兑换200京豆，一周可换四次；

export CASH_EXCHANGE=""

################################## 定义jd_superMarket蓝币兑换数量（选填） ##################################
## jd_superMarket蓝币兑换，可用值包括：
## 一、0：表示不兑换京豆，这也是js脚本的默认值
## 二、20：表示兑换20个京豆
## 三、1000：表示兑换1000个京豆
## 四、可兑换清单的商品名称，输入能跟唯一识别出来的关键词即可，比如：MARKET_COIN_TO_BEANS="抽纸"
## 注意：有些比较贵的实物商品JD只是展示出来忽悠人的，即使你零点用脚本去抢，也会提示没有或提示已下架
export MARKET_COIN_TO_BEANS="0"


################################## 定义jd_superMarket蓝币成功兑换奖品是否静默运行（选填） ##################################
## 默认 "false" 关闭（即:奖品兑换成功后会发出通知提示），如需要静默运行不发出通知，请改为 "true"
export MARKET_REWARD_NOTIFY=""


################################## 定义jd_superMarket是否自动使用金币去抽奖（选填） ##################################
## 是否用金币去抽奖，默认 "false" 关闭，如需开启，请修改为 "true"
export SUPERMARKET_LOTTERY=""


################################## 定义jd_superMarket是否自动参加PK队伍（选填） ##################################
## 是否每次PK活动参加脚本作者创建的PK队伍，"true" 表示参加，"false" 表示不参加，默认为 "true"
export JOIN_PK_TEAM=""


################################## 定义jd_fruit是否静默运行（选填） ##################################
## 默认为 "false"，不静默，发送推送通知消息，如不想收到通知，请修改为 "true"
## 如果你不想完全关闭或者完全开启通知，只想在特定的时间发送通知，可以参考下面的“定义jd_pet是否静默运行”部分，设定几个if判断条件
export FRUIT_NOTIFY_CONTROL=""


################################## 定义jd_fruit是否使用水滴换豆卡（选填） ##################################
## 如果出现限时活动时100g水换20豆，此时比浇水划算，"true" 表示换豆（不浇水），"false" 表示不换豆（继续浇水）,默认是"false"
## 如需切换为换豆（不浇水），请修改为 "true"
export FRUIT_BEAN_CARD=""


################################## 定义jd_joy喂食克数（选填） ##################################
## 你期望的jd_joy每次喂食克数，只能填入10、20、40、80，默认为10
## 如实际持有食物量小于所设置的克数，脚本会自动降一档，直到降无可降
## 具体情况请自行在jd_joy游戏中去查阅攻略
export JOY_FEED_COUNT=""


################################## 定义jd_joy兑换京豆数量（选填） ##################################
## 目前的可用值包括：0、20、500、1000，其中0表示为不自动兑换京豆，如不设置，将默认为"20"
## 不同等级可兑换不同数量的京豆，详情请见jd_joy游戏中兑换京豆选项
## 500、1000的京豆每天有总量限制，设置了并且你也有足够积分时，也并不代表就一定能抢到
export JD_JOY_REWARD_NAME=""


################################## 定义jd_joy兑换京豆是否静默运行（选填） ##################################
## 默认为 "false"，在成功兑换京豆时将发送推送通知消息（失败不发送），如想要静默不发送通知，请修改为 "true"
export JD_JOY_REWARD_NOTIFY=""


################################## 定义jd_joy是否自动给好友的汪汪喂食（选填） ##################################
## 默认 "false" 不会自动给好友的汪汪喂食，如想自动喂食，请改成 "true"
export JOY_HELP_FEED=""


################################## 定义jd_joy是否自动报名宠物赛跑（选填） ##################################
## 默认 "true" 参加宠物赛跑，如需关闭，请改成 "false"
export JOY_RUN_FLAG=""


################################## 定义jd_joy参加比赛类型（选填） ##################################
## 当JOY_RUN_FLAG不设置或设置为 "true" 时生效
## 可选值：2,10,50，其他值不可以。其中2代表参加双人PK赛，10代表参加10人突围赛，50代表参加50人挑战赛，不填时默认为2
## 各个账号间请使用 & 分隔，比如：JOY_TEAM_LEVEL="2&2&50&10"
## 如果你有5个账号但只写了四个数字，那么第5个账号将默认参加2人赛，账号如果更多，与此类似
export JOY_TEAM_LEVEL=""


################################## 定义jd_joy赛跑自己账号内部是否开启互助（选填） ##################################
## 输入 true 为开启内部互助
export JOY_RUN_HELP_MYSELF=""


################################## 定义jd_joy赛跑获胜后是否推送通知（选填） ##################################
## 控制jd_joy.js脚本jd_joy赛跑获胜后是否推送通知，"false" 为否(不推送通知消息)，"true" 为是(即：发送推送通知消息)，默认为 "true"
export JOY_RUN_NOTIFY=""


################################## 定义jd_moneyTree是否自动将金果卖出变成金币（选填） ##################################
## 金币有时效，默认为 "false"，不卖出金果为金币，如想希望自动卖出，请修改为 "true"
export MONEY_TREE_SELL_FRUIT=""


################################## 定义jd_pet是否静默运行（选填） ##################################
## 默认 "false"（不静默，发送推送通知消息），如想静默请修改为 true
## 每次执行脚本通知太频繁了，改成只在周三和周六中午那一次运行时发送通知提醒
## 除掉上述提及时间之外，均设置为 true，静默不发通知
## 特别说明：针对北京时间有效。
if [ $(date "+%w") -eq 6 ] && [ $(date "+%H") -ge 9 ] && [ $(date "+%H") -lt 14 ]; then
  export PET_NOTIFY_CONTROL="false"
elif [ $(date "+%w") -eq 3 ] && [ $(date "+%H") -ge 9 ] && [ $(date "+%H") -lt 14 ]; then
  export PET_NOTIFY_CONTROL="false"
else
  export PET_NOTIFY_CONTROL="true"
fi


################################## 定义jd_dreamFactory控制哪个JD账号不运行此脚本（选填） ##################################
## 输入"1"代表第一个JD账号不运行，多个使用 & 连接，例："1&3" 代表账号1和账号3不运行jd_dreamFactory脚本，注：输入"0"，代表全部账号不运行jd_dreamFactory脚本
## 如果使用了 “临时屏蔽某个Cookie” TempBlockCookie 功能，编号会发生变化
export DREAMFACTORY_FORBID_ACCOUNT=""


################################## 定义jd_jdfactory控制哪个JD账号不运行此脚本（选填） ##################################
## 输入"1"代表第一个JD账号不运行，多个使用 & 连接，例："1&3" 代表账号1和账号3不运行jd_jdfactory脚本，注：输入"0"，代表全部账号不运行jd_jdfactory脚本
## 如果使用了 “临时屏蔽某个Cookie” TempBlockCookie 功能，编号会发生变化
export JDFACTORY_FORBID_ACCOUNT=""


################################## 定义jd_jdfactory心仪的商品（选填） ##################################
## 只有在满足以下条件时，才自动投入电力：一是存储的电力满足生产商品所需的电力，二是心仪的商品有库存，如果没有输入心仪的商品，那么当前你正在生产的商品视作心仪的商品
## 如果你看不懂上面的话，请去jd_jdfactory游戏中查阅攻略
## 心仪的商品请输入商品的全称或能唯一识别出该商品的关键字
export FACTORAY_WANTPRODUCT_NAME=""


################################## 定义jd_jxnc通知级别（选填） ##################################
## 可用值： 0(不通知); 1(本次获得水滴>0); 2(任务执行); 3(任务执行+未种植种子)，默认为"3"
export JXNC_NOTIFY_LEVEL="3"


################################## 定义jd_cfd通知开关（选填） ##################################
## 输入 true 为通知，不填则为不通知
export CFD_NOTIFY_CONTROL=""


################################## 定义jd_jxd是否自动把抽奖卷兑换为兑币 ##################################
## 输入 true 为自动兑换，不填则为不兑换
export JD_JXD_EXCHANGE=""


################################## 定义jd_necklace是否是否静默运行 ##################################
## 控制jd_necklace是否静默运行，false 为否(发送推送通知消息)，true 为是(即：不发送推送通知消息)
export DDQ_NOTIFY_CONTROL=""


################################## 定义jd_cash是否是否静默运行 ##################################
## 控制jd_cash是否静默运行，false 为否(发送推送通知消息)，true 为是(即：不发送推送通知消息)
export CASH_NOTIFY_CONTROL=""

################################## 定义jd_jdzz是否是否静默运行 ##################################
## 控制jd_jdzz是否静默运行，false 为否(发送推送通知消息)，true 为是(即：不发送推送通知消息)
export JDZZ_NOTIFY_CONTROL=""

################################## 定义取关参数（选填） ##################################
## jd_unsubscribe这个任务是用来取关每天做任务关注的商品和店铺，默认在每次运行时取关20个商品和20个店铺
## 如果取关数量不够，可以根据情况增加，还可以设置 jdUnsubscribeStopGoods 和 jdUnsubscribeStopShop 
## 商品取关数量
goodPageSize=""
## 店铺取关数量
shopPageSize=""
## 遇到此商品不再取关此商品以及它后面的商品，需去商品详情页长按拷贝商品信息
jdUnsubscribeStopGoods=""
## 遇到此店铺不再取关此店铺以及它后面的店铺，请从头开始输入店铺名称
jdUnsubscribeStopShop=""


################################## 定义注销店铺会员参数（选填） ##################################
## jd_unbind脚本需要的，注销JD已开的店铺会员，不是注销JDplus会员，个别店铺无法注销
## 此参数控制每次运行脚本时注销多少个店铺会员，默认200
export UN_BIND_CARD_NUM=""

## 遇到此参数设定的会员卡则跳过不进行注销，多个会员卡之间以 & 分隔，默认值"JDPLUS会员"
export UN_BIND_STOP_CARD=""


################################## jd_crazy_joy（选填） ##################################
## jd_crazy_joy循环助力，"true" 表示循环助力，"false" 表示不循环助力，默认 "false"
export JDJOY_HELPSELF=""

## jd_crazy_joy京豆兑换，目前最小值为500/1000京豆，默认为 "0" 不开启京豆兑换
export JDJOY_APPLYJDBEAN=""

## jd_crazy_joy自动购买什么等级的JOY，如需要使用请自行解除注释
# export BUY_JOY_LEVEL=""


################################## 定义是否自动加购物车（选填） ##################################
## jd_small_home，和jd_jump有些任务需要将商品加进购物车才能完成，默认 "false" 不做这些任务，如想做，请设置为 "true"
export PURCHASE_SHOPS=""


################################## Telegram 代理（选填） ##################################
## Telegram 代理的 IP，代理类型为 http，比如你代理是 http://127.0.0.1:1080，则填写 "127.0.0.1"
## 如需使用，请自行解除下一行的注释
# export TG_PROXY_HOST=""

## Telegram 代理的端口，代理类型为 http，比如你代理是 http://127.0.0.1:1080，则填写 "1080"
## 如需使用，请自行解除下一行的注释
# export TG_PROXY_PORT=""


################################## 是否添加DIY脚本（选填） ##################################
## 如果你自己会写shell脚本，并且希望在每次git_pull.sh这个脚本运行时，额外运行你的DIY脚本，请赋值为 "true"
## 同时，请务必将你的脚本命名为 diy.sh (只能叫这个文件名)，放在 config 目录下
## 我已定义好的变量，你如果想直接使用，可以参考本仓库下 git_pull.sh 文件
EnableExtraShell=""


################################## 互助码填法示例 ##################################
## **互助码是填在My系列变量中的，ForOther系统变量中只要填入My系列的变量名即可，按注释中的例子拼接，以jd_fruit为例，如下所示。**
## **实际上jd_fruit一个账号只能给别人助力3次，我多写的话，只有前几个会被助力。但如果前面的账号获得的助力次数已经达到上限了，那么还是会尝试继续给余下的账号助力，所以多填也是有意义的。**
## **ForOther系列变量必须从1开始编号，依次编下去。**

# MyFruit1="e6e04602d5e343258873af1651b603ec"  # 这是Cookie1这个账号的互助码
# MyFruit2="52801b06ce2a462f95e1d59d7e856ef4"  # 这是Cookie2这个账号的互助码
# MyFruit3="e2fd1311229146cc9507528d0b054da8"  # 这是Cookie3这个账号的互助码
# MyFruit4="6dc9461f662d490991a31b798f624128"  # 这是Cookie4这个账号的互助码
# MyFruit5="30f29addd75d44e88fb452bbfe9f2110"  # 这是Cookie5这个账号的互助码
# MyFruit6="1d02fc9e0e574b4fa928e84cb1c5e70b"  # 这是Cookie6这个账号的互助码
# MyFruitA="5bc73a365ff74a559bdee785ea97fcc5"  # 这是我和别人交换互助，另外一个用户A的互助码
# MyFruitB="6d402dcfae1043fba7b519e0d6579a6f"  # 这是我和别人交换互助，另外一个用户B的互助码
# MyFruitC="5efc7fdbb8e0436f8694c4c393359576"  # 这是我和别人交换互助，另外一个用户C的互助码

# ForOtherFruit1="${MyFruit2}@${MyFruitB}@${MyFruit4}"   # Cookie1这个账号助力Cookie2的账号的账号、Cookie4的账号以及用户B
# ForOtherFruit2="${MyFruit1}@${MyFruitA}@${MyFruit4}"   # Cookie2这个账号助力Cookie1的账号的账号、Cookie4的账号以及用户A
# ForOtherFruit3="${MyFruit1}@${MyFruit2}@${MyFruitC}@${MyFruit4}@${MyFruitA}@${MyFruit6}"  # 解释同上，jd_fruit实际上只能助力3次
# ForOtherFruit4="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruitC}@${MyFruit6}@${MyFruitA}"  # 解释同上，jd_fruit实际上只能助力3次
# ForOtherFruit5="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruitB}@${MyFruit4}@${MyFruit6}@${MyFruitC}@${MyFruitA}"
# ForOtherFruit6="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruitA}@${MyFruit4}@${MyFruit5}@${MyFruitC}"


################################## 额外的环境变量（选填） ##################################
## 请在以下补充你需要用到的额外的环境变量，形式：export 变量名="变量值"
