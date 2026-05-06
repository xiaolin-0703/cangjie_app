package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.service.CircleService

@Entry
@Component
class CircleDetailPage {
    @State var circleId: String = ""
    @State var circleName: String = "圈子详情"
    @State var circleDesc: String = "暂无简介"
    @State var memberText: String = "0人已加入"
    @State var joinedText: String = "false"

    @State var loading: Bool = false
    @State var errorMsg: String = ""

    @State var member1UserId: String = ""
    @State var member1Name: String = ""
    @State var member1AvatarUrl: String = ""
    @State var member1TagText: String = ""
    @State var member1Hobbies: String = ""
    @State var member1Role: String = ""

    @State var member2UserId: String = ""
    @State var member2Name: String = ""
    @State var member2AvatarUrl: String = ""
    @State var member2TagText: String = ""
    @State var member2Hobbies: String = ""
    @State var member2Role: String = ""

    @State var member3UserId: String = ""
    @State var member3Name: String = ""
    @State var member3AvatarUrl: String = ""
    @State var member3TagText: String = ""
    @State var member3Hobbies: String = ""
    @State var member3Role: String = ""

    @State var member4UserId: String = ""
    @State var member4Name: String = ""
    @State var member4AvatarUrl: String = ""
    @State var member4TagText: String = ""
    @State var member4Hobbies: String = ""
    @State var member4Role: String = ""

    @State var member5UserId: String = ""
    @State var member5Name: String = ""
    @State var member5AvatarUrl: String = ""
    @State var member5TagText: String = ""
    @State var member5Hobbies: String = ""
    @State var member5Role: String = ""

    @State var post1Id: String = ""
    @State var post1Title: String = ""
    @State var post1Content: String = ""
    @State var post1Author: String = ""
    @State var post1AvatarUrl: String = ""
    @State var post1Time: String = ""
    @State var post1ImageUrl: String = ""
    @State var post1LikeCount: String = "0"
    @State var post1CommentCount: String = "0"
    @State var post1LikedByMe: String = "false"

    @State var post2Id: String = ""
    @State var post2Title: String = ""
    @State var post2Content: String = ""
    @State var post2Author: String = ""
    @State var post2AvatarUrl: String = ""
    @State var post2Time: String = ""
    @State var post2ImageUrl: String = ""
    @State var post2LikeCount: String = "0"
    @State var post2CommentCount: String = "0"
    @State var post2LikedByMe: String = "false"

    @State var post3Id: String = ""
    @State var post3Title: String = ""
    @State var post3Content: String = ""
    @State var post3Author: String = ""
    @State var post3AvatarUrl: String = ""
    @State var post3Time: String = ""
    @State var post3ImageUrl: String = ""
    @State var post3LikeCount: String = "0"
    @State var post3CommentCount: String = "0"
    @State var post3LikedByMe: String = "false"

    @State var post4Id: String = ""
    @State var post4Title: String = ""
    @State var post4Content: String = ""
    @State var post4Author: String = ""
    @State var post4AvatarUrl: String = ""
    @State var post4Time: String = ""
    @State var post4ImageUrl: String = ""
    @State var post4LikeCount: String = "0"
    @State var post4CommentCount: String = "0"
    @State var post4LikedByMe: String = "false"

    @State var post5Id: String = ""
    @State var post5Title: String = ""
    @State var post5Content: String = ""
    @State var post5Author: String = ""
    @State var post5AvatarUrl: String = ""
    @State var post5Time: String = ""
    @State var post5ImageUrl: String = ""
    @State var post5LikeCount: String = "0"
    @State var post5CommentCount: String = "0"
    @State var post5LikedByMe: String = "false"

    @State var activeCommentPostId: String = ""
    @State var activeCommentPostTitle: String = ""
    @State var commentInput: String = ""
    @State var commentLoading: Bool = false
    @State var commentSubmitting: Bool = false
    @State var commentMsg: String = ""

    @State var comment1Name: String = ""
    @State var comment1AvatarUrl: String = ""
    @State var comment1Content: String = ""
    @State var comment1Time: String = ""

    @State var comment2Name: String = ""
    @State var comment2AvatarUrl: String = ""
    @State var comment2Content: String = ""
    @State var comment2Time: String = ""

    @State var comment3Name: String = ""
    @State var comment3AvatarUrl: String = ""
    @State var comment3Content: String = ""
    @State var comment3Time: String = ""

    @State var comment4Name: String = ""
    @State var comment4AvatarUrl: String = ""
    @State var comment4Content: String = ""
    @State var comment4Time: String = ""

    @State var comment5Name: String = ""
    @State var comment5AvatarUrl: String = ""
    @State var comment5Content: String = ""
    @State var comment5Time: String = ""

    public func aboutToAppear(): Unit {
        this.circleId = CircleService.getCurrentCircleId()
        this.circleName = CircleService.getCurrentCircleName()
        this.circleDesc = CircleService.getCurrentCircleDescription()
        this.memberText = CircleService.getCurrentCircleMemberText()
        this.joinedText = CircleService.getCurrentCircleJoinedText()

        if (this.circleId != "") {
            this.loadCircleDetail()
            this.loadMembers()
            this.loadPosts()
        } else {
            this.errorMsg = "圈子 ID 缺失"
        }
    }

    func getRefreshText(): String {
        if (this.loading) {
            return "刷新中..."
        }
        return "刷新内容"
    }

    func refreshPage() {
        this.loadCircleDetail()
        this.loadMembers()
        this.loadPosts()
        if (this.activeCommentPostId != "") {
            this.loadComments()
        }
    }

    func clearPosts() {
        this.post1Id = ""
        this.post1Title = ""
        this.post1Content = ""
        this.post1Author = ""
        this.post1AvatarUrl = ""
        this.post1Time = ""
        this.post1ImageUrl = ""
        this.post1LikeCount = "0"
        this.post1CommentCount = "0"
        this.post1LikedByMe = "false"

        this.post2Id = ""
        this.post2Title = ""
        this.post2Content = ""
        this.post2Author = ""
        this.post2AvatarUrl = ""
        this.post2Time = ""
        this.post2ImageUrl = ""
        this.post2LikeCount = "0"
        this.post2CommentCount = "0"
        this.post2LikedByMe = "false"

        this.post3Id = ""
        this.post3Title = ""
        this.post3Content = ""
        this.post3Author = ""
        this.post3AvatarUrl = ""
        this.post3Time = ""
        this.post3ImageUrl = ""
        this.post3LikeCount = "0"
        this.post3CommentCount = "0"
        this.post3LikedByMe = "false"

        this.post4Id = ""
        this.post4Title = ""
        this.post4Content = ""
        this.post4Author = ""
        this.post4AvatarUrl = ""
        this.post4Time = ""
        this.post4ImageUrl = ""
        this.post4LikeCount = "0"
        this.post4CommentCount = "0"
        this.post4LikedByMe = "false"

        this.post5Id = ""
        this.post5Title = ""
        this.post5Content = ""
        this.post5Author = ""
        this.post5AvatarUrl = ""
        this.post5Time = ""
        this.post5ImageUrl = ""
        this.post5LikeCount = "0"
        this.post5CommentCount = "0"
        this.post5LikedByMe = "false"
    }

    func clearMembers() {
        this.member1UserId = ""
        this.member1Name = ""
        this.member1AvatarUrl = ""
        this.member1TagText = ""
        this.member1Hobbies = ""
        this.member1Role = ""

        this.member2UserId = ""
        this.member2Name = ""
        this.member2AvatarUrl = ""
        this.member2TagText = ""
        this.member2Hobbies = ""
        this.member2Role = ""

        this.member3UserId = ""
        this.member3Name = ""
        this.member3AvatarUrl = ""
        this.member3TagText = ""
        this.member3Hobbies = ""
        this.member3Role = ""

        this.member4UserId = ""
        this.member4Name = ""
        this.member4AvatarUrl = ""
        this.member4TagText = ""
        this.member4Hobbies = ""
        this.member4Role = ""

        this.member5UserId = ""
        this.member5Name = ""
        this.member5AvatarUrl = ""
        this.member5TagText = ""
        this.member5Hobbies = ""
        this.member5Role = ""
    }

    func hasPosts(): Bool {
        return this.post1Title != "" ||
            this.post2Title != "" ||
            this.post3Title != "" ||
            this.post4Title != "" ||
            this.post5Title != ""
    }

    func hasMembers(): Bool {
        return this.member1Name != "" ||
            this.member2Name != "" ||
            this.member3Name != "" ||
            this.member4Name != "" ||
            this.member5Name != ""
    }

    func roleLabel(role: String): String {
        if (role == "owner") {
            return "圈主"
        }
        if (role == "admin") {
            return "管理员"
        }
        return "成员"
    }

    func safeTagText(tagText: String): String {
        if (tagText == "") {
            return "圈子成员"
        }
        return tagText
    }

    func openMemberProfile(userId: String, nickname: String, avatarUrl: String, tagText: String, hobbies: String, role: String) {
        if (userId == "") {
            return
        }

        CircleService.setCurrentMemberProfile(
            userId,
            nickname,
            avatarUrl,
            this.safeTagText(tagText),
            hobbies,
            role
        )
        Router.push(url: "MemberProfilePage")
    }

    func loadCircleDetail() {
        CircleService.getCircleDetail(
            this.circleId,
            { raw: String =>
                this.circleName = CircleService.extractSingleCircleField(raw, "name")
                this.circleDesc = CircleService.extractSingleCircleField(raw, "description")
                this.memberText = CircleService.formatMemberText(
                    CircleService.extractSingleCircleField(raw, "memberCount")
                )
                this.joinedText = CircleService.extractSingleCircleField(raw, "joined")

                CircleService.setCurrentCircleDetail(
                    this.circleId,
                    this.circleName,
                    this.circleDesc,
                    this.memberText,
                    this.joinedText
                )
            },
            { msg: String =>
                this.errorMsg = msg
            }
        )
    }

    func loadPosts() {
        this.loading = true
        this.errorMsg = ""
        this.clearPosts()

        CircleService.getCirclePosts(
            this.circleId,
            { raw: String =>
                this.post1Id = CircleService.extractPostField(raw, 0, "id")
                this.post1Title = CircleService.extractPostField(raw, 0, "title")
                this.post1Content = CircleService.extractPostField(raw, 0, "content")
                this.post1Author = CircleService.extractPostField(raw, 0, "nickname")
                this.post1AvatarUrl = CircleService.extractPostField(raw, 0, "avatarUrl")
                this.post1Time = CircleService.extractPostField(raw, 0, "createdAt")
                this.post1ImageUrl = CircleService.extractPostField(raw, 0, "imageUrl")
                this.post1LikeCount = CircleService.extractPostField(raw, 0, "likeCount")
                this.post1CommentCount = CircleService.extractPostField(raw, 0, "commentCount")
                this.post1LikedByMe = CircleService.extractPostField(raw, 0, "likedByMe")

                this.post2Id = CircleService.extractPostField(raw, 1, "id")
                this.post2Title = CircleService.extractPostField(raw, 1, "title")
                this.post2Content = CircleService.extractPostField(raw, 1, "content")
                this.post2Author = CircleService.extractPostField(raw, 1, "nickname")
                this.post2AvatarUrl = CircleService.extractPostField(raw, 1, "avatarUrl")
                this.post2Time = CircleService.extractPostField(raw, 1, "createdAt")
                this.post2ImageUrl = CircleService.extractPostField(raw, 1, "imageUrl")
                this.post2LikeCount = CircleService.extractPostField(raw, 1, "likeCount")
                this.post2CommentCount = CircleService.extractPostField(raw, 1, "commentCount")
                this.post2LikedByMe = CircleService.extractPostField(raw, 1, "likedByMe")

                this.post3Id = CircleService.extractPostField(raw, 2, "id")
                this.post3Title = CircleService.extractPostField(raw, 2, "title")
                this.post3Content = CircleService.extractPostField(raw, 2, "content")
                this.post3Author = CircleService.extractPostField(raw, 2, "nickname")
                this.post3AvatarUrl = CircleService.extractPostField(raw, 2, "avatarUrl")
                this.post3Time = CircleService.extractPostField(raw, 2, "createdAt")
                this.post3ImageUrl = CircleService.extractPostField(raw, 2, "imageUrl")
                this.post3LikeCount = CircleService.extractPostField(raw, 2, "likeCount")
                this.post3CommentCount = CircleService.extractPostField(raw, 2, "commentCount")
                this.post3LikedByMe = CircleService.extractPostField(raw, 2, "likedByMe")

                this.post4Id = CircleService.extractPostField(raw, 3, "id")
                this.post4Title = CircleService.extractPostField(raw, 3, "title")
                this.post4Content = CircleService.extractPostField(raw, 3, "content")
                this.post4Author = CircleService.extractPostField(raw, 3, "nickname")
                this.post4AvatarUrl = CircleService.extractPostField(raw, 3, "avatarUrl")
                this.post4Time = CircleService.extractPostField(raw, 3, "createdAt")
                this.post4ImageUrl = CircleService.extractPostField(raw, 3, "imageUrl")
                this.post4LikeCount = CircleService.extractPostField(raw, 3, "likeCount")
                this.post4CommentCount = CircleService.extractPostField(raw, 3, "commentCount")
                this.post4LikedByMe = CircleService.extractPostField(raw, 3, "likedByMe")

                this.post5Id = CircleService.extractPostField(raw, 4, "id")
                this.post5Title = CircleService.extractPostField(raw, 4, "title")
                this.post5Content = CircleService.extractPostField(raw, 4, "content")
                this.post5Author = CircleService.extractPostField(raw, 4, "nickname")
                this.post5AvatarUrl = CircleService.extractPostField(raw, 4, "avatarUrl")
                this.post5Time = CircleService.extractPostField(raw, 4, "createdAt")
                this.post5ImageUrl = CircleService.extractPostField(raw, 4, "imageUrl")
                this.post5LikeCount = CircleService.extractPostField(raw, 4, "likeCount")
                this.post5CommentCount = CircleService.extractPostField(raw, 4, "commentCount")
                this.post5LikedByMe = CircleService.extractPostField(raw, 4, "likedByMe")

                this.loading = false
            },
            { msg: String =>
                this.loading = false
                this.errorMsg = msg
            }
        )
    }

    func loadMembers() {
        this.clearMembers()

        CircleService.getCircleMembers(
            this.circleId,
            { raw: String =>
                this.member1UserId = CircleService.extractMemberField(raw, 0, "userId")
                this.member1Name = CircleService.extractMemberField(raw, 0, "nickname")
                this.member1AvatarUrl = CircleService.extractMemberField(raw, 0, "avatarUrl")
                this.member1TagText = CircleService.extractMemberField(raw, 0, "tagText")
                this.member1Hobbies = CircleService.extractMemberField(raw, 0, "hobbies")
                this.member1Role = CircleService.extractMemberField(raw, 0, "role")

                this.member2UserId = CircleService.extractMemberField(raw, 1, "userId")
                this.member2Name = CircleService.extractMemberField(raw, 1, "nickname")
                this.member2AvatarUrl = CircleService.extractMemberField(raw, 1, "avatarUrl")
                this.member2TagText = CircleService.extractMemberField(raw, 1, "tagText")
                this.member2Hobbies = CircleService.extractMemberField(raw, 1, "hobbies")
                this.member2Role = CircleService.extractMemberField(raw, 1, "role")

                this.member3UserId = CircleService.extractMemberField(raw, 2, "userId")
                this.member3Name = CircleService.extractMemberField(raw, 2, "nickname")
                this.member3AvatarUrl = CircleService.extractMemberField(raw, 2, "avatarUrl")
                this.member3TagText = CircleService.extractMemberField(raw, 2, "tagText")
                this.member3Hobbies = CircleService.extractMemberField(raw, 2, "hobbies")
                this.member3Role = CircleService.extractMemberField(raw, 2, "role")

                this.member4UserId = CircleService.extractMemberField(raw, 3, "userId")
                this.member4Name = CircleService.extractMemberField(raw, 3, "nickname")
                this.member4AvatarUrl = CircleService.extractMemberField(raw, 3, "avatarUrl")
                this.member4TagText = CircleService.extractMemberField(raw, 3, "tagText")
                this.member4Hobbies = CircleService.extractMemberField(raw, 3, "hobbies")
                this.member4Role = CircleService.extractMemberField(raw, 3, "role")

                this.member5UserId = CircleService.extractMemberField(raw, 4, "userId")
                this.member5Name = CircleService.extractMemberField(raw, 4, "nickname")
                this.member5AvatarUrl = CircleService.extractMemberField(raw, 4, "avatarUrl")
                this.member5TagText = CircleService.extractMemberField(raw, 4, "tagText")
                this.member5Hobbies = CircleService.extractMemberField(raw, 4, "hobbies")
                this.member5Role = CircleService.extractMemberField(raw, 4, "role")
            },
            { msg: String =>
                this.errorMsg = msg
            }
        )
    }

    func joinCurrentCircle() {
        CircleService.joinCircle(
            this.circleId,
            { _: String =>
                this.joinedText = "true"
                this.loadCircleDetail()
                this.loadMembers()
            },
            { msg: String =>
                this.errorMsg = msg
            }
        )
    }

    func postStatsText(likeCount: String, commentCount: String): String {
        let safeLike = if (likeCount == "") { "0" } else { likeCount }
        let safeComment = if (commentCount == "") { "0" } else { commentCount }
        return "点赞 " + safeLike + " · 评论 " + safeComment
    }

    func likeButtonText(likedByMe: String): String {
        if (likedByMe == "true") {
            return "已点赞"
        }
        return "点赞"
    }

    func likePost(postId: String) {
        CircleService.likePost(
            postId,
            { _: String =>
                this.loadPosts()
            },
            { msg: String =>
                this.errorMsg = msg
            }
        )
    }

    func commentButtonText(postId: String): String {
        if (postId != "" && postId == this.activeCommentPostId) {
            return "查看中"
        }
        return "评论"
    }

    func clearComments() {
        this.comment1Name = ""
        this.comment1AvatarUrl = ""
        this.comment1Content = ""
        this.comment1Time = ""

        this.comment2Name = ""
        this.comment2AvatarUrl = ""
        this.comment2Content = ""
        this.comment2Time = ""

        this.comment3Name = ""
        this.comment3AvatarUrl = ""
        this.comment3Content = ""
        this.comment3Time = ""

        this.comment4Name = ""
        this.comment4AvatarUrl = ""
        this.comment4Content = ""
        this.comment4Time = ""

        this.comment5Name = ""
        this.comment5AvatarUrl = ""
        this.comment5Content = ""
        this.comment5Time = ""
    }

    func hasComments(): Bool {
        return this.comment1Content != "" ||
            this.comment2Content != "" ||
            this.comment3Content != "" ||
            this.comment4Content != "" ||
            this.comment5Content != ""
    }

    func openComments(postId: String, title: String) {
        if (postId == "") {
            return
        }

        this.activeCommentPostId = postId
        this.activeCommentPostTitle = title
        this.commentInput = ""
        this.commentMsg = ""
        this.loadComments()
    }

    func loadComments() {
        if (this.activeCommentPostId == "") {
            return
        }

        this.commentLoading = true
        this.commentMsg = ""
        this.clearComments()

        CircleService.getPostComments(
            this.activeCommentPostId,
            { raw: String =>
                this.comment1Name = CircleService.extractCommentField(raw, 0, "nickname")
                this.comment1AvatarUrl = CircleService.extractCommentField(raw, 0, "avatarUrl")
                this.comment1Content = CircleService.extractCommentField(raw, 0, "content")
                this.comment1Time = CircleService.extractCommentField(raw, 0, "createdAt")

                this.comment2Name = CircleService.extractCommentField(raw, 1, "nickname")
                this.comment2AvatarUrl = CircleService.extractCommentField(raw, 1, "avatarUrl")
                this.comment2Content = CircleService.extractCommentField(raw, 1, "content")
                this.comment2Time = CircleService.extractCommentField(raw, 1, "createdAt")

                this.comment3Name = CircleService.extractCommentField(raw, 2, "nickname")
                this.comment3AvatarUrl = CircleService.extractCommentField(raw, 2, "avatarUrl")
                this.comment3Content = CircleService.extractCommentField(raw, 2, "content")
                this.comment3Time = CircleService.extractCommentField(raw, 2, "createdAt")

                this.comment4Name = CircleService.extractCommentField(raw, 3, "nickname")
                this.comment4AvatarUrl = CircleService.extractCommentField(raw, 3, "avatarUrl")
                this.comment4Content = CircleService.extractCommentField(raw, 3, "content")
                this.comment4Time = CircleService.extractCommentField(raw, 3, "createdAt")

                this.comment5Name = CircleService.extractCommentField(raw, 4, "nickname")
                this.comment5AvatarUrl = CircleService.extractCommentField(raw, 4, "avatarUrl")
                this.comment5Content = CircleService.extractCommentField(raw, 4, "content")
                this.comment5Time = CircleService.extractCommentField(raw, 4, "createdAt")

                this.commentLoading = false
            },
            { msg: String =>
                this.commentLoading = false
                this.commentMsg = msg
            }
        )
    }

    func submitComment() {
        if (this.activeCommentPostId == "") {
            this.commentMsg = "请先选择要评论的帖子"
            return
        }

        if (this.commentInput == "") {
            this.commentMsg = "评论内容不能为空"
            return
        }

        this.commentSubmitting = true
        this.commentMsg = ""

        CircleService.createPostComment(
            this.activeCommentPostId,
            this.commentInput,
            { _: String =>
                this.commentSubmitting = false
                this.commentInput = ""
                this.commentMsg = "评论已发布"
                this.loadPosts()
                this.loadComments()
            },
            { msg: String =>
                this.commentSubmitting = false
                this.commentMsg = msg
            }
        )
    }

    func build() {
        Column {
            Column {
                Row {
                    Column {
                        Text("圈子详情")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)
                            .margin(bottom: 6)

                        Text("查看圈子信息、帖子动态和加入状态")
                            .fontSize(14)
                            .fontColor(0xFF6D7B99)
                    }
                    .layoutWeight(1)

                    Text("详情")
                        .fontSize(13)
                        .fontColor(0xFF2F80FF)
                        .backgroundColor(0xFFFFFFFF)
                        .padding(left: 14, right: 14, top: 8, bottom: 8)
                        .borderRadius(18)
                }
                .width(100.percent)
                .margin(bottom: 16)

                Row {
                    Button("返回圈子")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFFFFFF)
                        .fontColor(0xFF2F80FF)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ _: ClickEvent =>
                            Router.push(url: "CirclesPage")
                        })

                    Button(this.getRefreshText())
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFF2F80FF)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(20)
                        .enabled(!this.loading)
                        .onClick({ _: ClickEvent =>
                            this.refreshPage()
                        })
                }
                .width(100.percent)
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFEAF2FF)

            Scroll {
                Column {
                    if (this.errorMsg != "") {
                        Column {
                            Text("加载失败")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text(this.errorMsg)
                                .fontSize(13)
                                .fontColor(0xFFE96B6B)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    Column {
                        Text(this.circleName)
                            .fontSize(22)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)
                            .margin(bottom: 8)

                        Text(this.memberText)
                            .fontSize(13)
                            .fontColor(0xFF2F80FF)
                            .margin(bottom: 10)

                        Text(this.circleDesc)
                            .fontSize(14)
                            .fontColor(0xFF6D7B99)
                            .margin(bottom: 16)

                        if (this.joinedText == "true") {
                            Button("已加入")
                                .width(100.percent)
                                .height(42)
                                .enabled(false)
                                .backgroundColor(0xFFEAF2FF)
                                .fontColor(0xFF2F80FF)
                                .borderRadius(14)
                                .margin(bottom: 12)
                        } else {
                            Button("加入圈子")
                                .width(100.percent)
                                .height(42)
                                .backgroundColor(0xFF2F80FF)
                                .fontColor(0xFFFFFFFF)
                                .borderRadius(14)
                                .margin(bottom: 12)
                                .onClick({ _: ClickEvent =>
                                    this.joinCurrentCircle()
                                })
                        }

                        Button("发布帖子")
                            .width(100.percent)
                            .height(42)
                            .backgroundColor(0xFFEAF2FF)
                            .fontColor(0xFF2F80FF)
                            .borderRadius(14)
                            .onClick({ _: ClickEvent =>
                                Router.push(url: "CreatePostPage")
                            })
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(20)
                    .margin(bottom: 12)

                    Column {
                        Row {
                            Text("圈子成员")
                                .fontSize(20)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)

                            Row {}
                                .layoutWeight(1)

                            Text(this.memberText)
                                .fontSize(12)
                                .fontColor(0xFF2F80FF)
                                .backgroundColor(0xFFEAF2FF)
                                .padding(left: 10, right: 10, top: 5, bottom: 5)
                                .borderRadius(12)
                        }
                        .width(100.percent)
                        .alignItems(VerticalAlign.Center)
                        .margin(bottom: 12)

                        if (!this.hasMembers()) {
                            Column {
                                Text("暂时还没有成员")
                                    .fontSize(17)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF24324A)
                                    .margin(bottom: 6)

                                Text("加入圈子后会在这里显示成员。")
                                    .fontSize(13)
                                    .fontColor(0xFF7E8CA8)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFF7FAFF)
                            .borderRadius(16)
                        } else {
                            if (this.member1Name != "") {
                                Row {
                                    if (this.member1AvatarUrl != "") {
                                        Image(this.member1AvatarUrl)
                                            .width(46)
                                            .height(46)
                                            .borderRadius(23)
                                            .margin(right: 12)
                                    } else {
                                        Row {
                                            Text("人")
                                                .fontSize(16)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(46)
                                        .height(46)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(VerticalAlign.Center)
                                        .backgroundColor(0xFF7AAFFF)
                                        .borderRadius(23)
                                        .margin(right: 12)
                                    }

                                    Column {
                                        Text(this.member1Name)
                                            .fontSize(16)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .margin(bottom: 5)

                                        Text(this.safeTagText(this.member1TagText))
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .maxLines(1)
                                            .textOverflow(TextOverflow.Ellipsis)
                                    }
                                    .layoutWeight(1)
                                    .alignItems(HorizontalAlign.Start)

                                    Text(this.roleLabel(this.member1Role))
                                        .fontSize(11)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 8, right: 8, top: 4, bottom: 4)
                                        .borderRadius(10)
                                }
                                .width(100.percent)
                                .padding(12)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .alignItems(VerticalAlign.Center)
                                .margin(bottom: 8)
                                .onClick({ _: ClickEvent =>
                                    this.openMemberProfile(this.member1UserId, this.member1Name, this.member1AvatarUrl, this.member1TagText, this.member1Hobbies, this.member1Role)
                                })
                            }

                            if (this.member2Name != "") {
                                Row {
                                    if (this.member2AvatarUrl != "") {
                                        Image(this.member2AvatarUrl)
                                            .width(46)
                                            .height(46)
                                            .borderRadius(23)
                                            .margin(right: 12)
                                    } else {
                                        Row {
                                            Text("人")
                                                .fontSize(16)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(46)
                                        .height(46)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(VerticalAlign.Center)
                                        .backgroundColor(0xFF8DBBFF)
                                        .borderRadius(23)
                                        .margin(right: 12)
                                    }

                                    Column {
                                        Text(this.member2Name)
                                            .fontSize(16)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .margin(bottom: 5)

                                        Text(this.safeTagText(this.member2TagText))
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .maxLines(1)
                                            .textOverflow(TextOverflow.Ellipsis)
                                    }
                                    .layoutWeight(1)
                                    .alignItems(HorizontalAlign.Start)

                                    Text(this.roleLabel(this.member2Role))
                                        .fontSize(11)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 8, right: 8, top: 4, bottom: 4)
                                        .borderRadius(10)
                                }
                                .width(100.percent)
                                .padding(12)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .alignItems(VerticalAlign.Center)
                                .margin(bottom: 8)
                                .onClick({ _: ClickEvent =>
                                    this.openMemberProfile(this.member2UserId, this.member2Name, this.member2AvatarUrl, this.member2TagText, this.member2Hobbies, this.member2Role)
                                })
                            }

                            if (this.member3Name != "") {
                                Row {
                                    if (this.member3AvatarUrl != "") {
                                        Image(this.member3AvatarUrl)
                                            .width(46)
                                            .height(46)
                                            .borderRadius(23)
                                            .margin(right: 12)
                                    } else {
                                        Row {
                                            Text("人")
                                                .fontSize(16)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(46)
                                        .height(46)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(VerticalAlign.Center)
                                        .backgroundColor(0xFF5A96FF)
                                        .borderRadius(23)
                                        .margin(right: 12)
                                    }

                                    Column {
                                        Text(this.member3Name)
                                            .fontSize(16)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .margin(bottom: 5)

                                        Text(this.safeTagText(this.member3TagText))
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .maxLines(1)
                                            .textOverflow(TextOverflow.Ellipsis)
                                    }
                                    .layoutWeight(1)
                                    .alignItems(HorizontalAlign.Start)

                                    Text(this.roleLabel(this.member3Role))
                                        .fontSize(11)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 8, right: 8, top: 4, bottom: 4)
                                        .borderRadius(10)
                                }
                                .width(100.percent)
                                .padding(12)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .alignItems(VerticalAlign.Center)
                                .margin(bottom: 8)
                                .onClick({ _: ClickEvent =>
                                    this.openMemberProfile(this.member3UserId, this.member3Name, this.member3AvatarUrl, this.member3TagText, this.member3Hobbies, this.member3Role)
                                })
                            }

                            if (this.member4Name != "") {
                                Row {
                                    if (this.member4AvatarUrl != "") {
                                        Image(this.member4AvatarUrl)
                                            .width(46)
                                            .height(46)
                                            .borderRadius(23)
                                            .margin(right: 12)
                                    } else {
                                        Row {
                                            Text("人")
                                                .fontSize(16)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(46)
                                        .height(46)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(VerticalAlign.Center)
                                        .backgroundColor(0xFF6FA6FF)
                                        .borderRadius(23)
                                        .margin(right: 12)
                                    }

                                    Column {
                                        Text(this.member4Name)
                                            .fontSize(16)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .margin(bottom: 5)

                                        Text(this.safeTagText(this.member4TagText))
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .maxLines(1)
                                            .textOverflow(TextOverflow.Ellipsis)
                                    }
                                    .layoutWeight(1)
                                    .alignItems(HorizontalAlign.Start)

                                    Text(this.roleLabel(this.member4Role))
                                        .fontSize(11)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 8, right: 8, top: 4, bottom: 4)
                                        .borderRadius(10)
                                }
                                .width(100.percent)
                                .padding(12)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .alignItems(VerticalAlign.Center)
                                .margin(bottom: 8)
                                .onClick({ _: ClickEvent =>
                                    this.openMemberProfile(this.member4UserId, this.member4Name, this.member4AvatarUrl, this.member4TagText, this.member4Hobbies, this.member4Role)
                                })
                            }

                            if (this.member5Name != "") {
                                Row {
                                    if (this.member5AvatarUrl != "") {
                                        Image(this.member5AvatarUrl)
                                            .width(46)
                                            .height(46)
                                            .borderRadius(23)
                                            .margin(right: 12)
                                    } else {
                                        Row {
                                            Text("人")
                                                .fontSize(16)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(46)
                                        .height(46)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(VerticalAlign.Center)
                                        .backgroundColor(0xFF9AC7FF)
                                        .borderRadius(23)
                                        .margin(right: 12)
                                    }

                                    Column {
                                        Text(this.member5Name)
                                            .fontSize(16)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .margin(bottom: 5)

                                        Text(this.safeTagText(this.member5TagText))
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .maxLines(1)
                                            .textOverflow(TextOverflow.Ellipsis)
                                    }
                                    .layoutWeight(1)
                                    .alignItems(HorizontalAlign.Start)

                                    Text(this.roleLabel(this.member5Role))
                                        .fontSize(11)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 8, right: 8, top: 4, bottom: 4)
                                        .borderRadius(10)
                                }
                                .width(100.percent)
                                .padding(12)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .alignItems(VerticalAlign.Center)
                                .onClick({ _: ClickEvent =>
                                    this.openMemberProfile(this.member5UserId, this.member5Name, this.member5AvatarUrl, this.member5TagText, this.member5Hobbies, this.member5Role)
                                })
                            }
                        }
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(20)
                    .margin(bottom: 14)

                    Text("圈子动态")
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(0xFF24324A)
                        .margin(bottom: 12)

                    if (!this.hasPosts() && !this.loading) {
                        Column {
                            Text("暂时还没有帖子")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text("快来发布第一条帖子吧。")
                                .fontSize(13)
                                .fontColor(0xFF7E8CA8)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.post1Title != "") {
                        Column {
                            Text(this.postStatsText(this.post1LikeCount, this.post1CommentCount))
                                .fontSize(12)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 8)

                            Row {
                                Button(this.likeButtonText(this.post1LikedByMe))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFEAF2FF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .margin(right: 8)
                                    .onClick({ =>
                                        this.likePost(this.post1Id)
                                    })

                                Button(this.commentButtonText(this.post1Id))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFF7FAFF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .onClick({ =>
                                        this.openComments(this.post1Id, this.post1Title)
                                    })
                            }
                            .width(100.percent)
                            .margin(bottom: 10)

                            Text(this.post1Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text(this.post1Content)
                                .fontSize(14)
                                .fontColor(0xFF6D7B99)
                                .margin(bottom: 10)

                            if (this.post1ImageUrl != "") {
                                Image(this.post1ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Row {
                                if (this.post1AvatarUrl != "") {
                                    Image(this.post1AvatarUrl)
                                        .width(34)
                                        .height(34)
                                        .borderRadius(17)
                                        .margin(right: 10)
                                } else {
                                    Row {
                                        Text("人")
                                            .fontSize(13)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFFFFFFFF)
                                    }
                                    .width(34)
                                    .height(34)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFF7AAFFF)
                                    .borderRadius(17)
                                    .margin(right: 10)
                                }

                                Text(this.post1Author)
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .layoutWeight(1)
                            }
                            .width(100.percent)
                            .alignItems(VerticalAlign.Center)
                            .margin(bottom: 8)

                            Text(this.post1Author + " · " + this.post1Time)
                                .fontSize(12)
                                .fontColor(0xFF2F80FF)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.activeCommentPostId != "" && this.activeCommentPostId == this.post1Id) {
                        Column {
                            Text("评论 · " + this.post1Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 10)
                            TextInput(placeholder: "写下你的评论").width(100.percent).height(72).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 10).onChange({ v: String => this.commentInput = v })
                            Button("发表评论").width(100.percent).height(40).enabled(!this.commentSubmitting).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).borderRadius(16).margin(bottom: 12).onClick({ => this.submitComment() })
                            if (this.commentMsg != "") { Text(this.commentMsg).fontSize(13).fontColor(0xFF2F80FF).margin(bottom: 10) }
                            if (this.commentLoading) {
                                Text("评论加载中...").fontSize(13).fontColor(0xFF7E8CA8)
                            } else if (!this.hasComments()) {
                                Text("还没有评论，来写第一条吧。").fontSize(13).fontColor(0xFF7E8CA8)
                            } else {
                                if (this.comment1Content != "") {
                                    Row {
                                        if (this.comment1AvatarUrl != "") { Image(this.comment1AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF7AAFFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment1Name + " · " + this.comment1Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment1Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment2Content != "") {
                                    Row {
                                        if (this.comment2AvatarUrl != "") { Image(this.comment2AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF8DBBFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment2Name + " · " + this.comment2Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment2Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment3Content != "") {
                                    Row {
                                        if (this.comment3AvatarUrl != "") { Image(this.comment3AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF5A96FF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment3Name + " · " + this.comment3Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment3Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center)
                                }
                            }
                        }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 12)
                    }

                    if (this.post2Title != "") {
                        Column {
                            Text(this.postStatsText(this.post2LikeCount, this.post2CommentCount))
                                .fontSize(12)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 8)

                            Row {
                                Button(this.likeButtonText(this.post2LikedByMe))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFEAF2FF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .margin(right: 8)
                                    .onClick({ =>
                                        this.likePost(this.post2Id)
                                    })

                                Button(this.commentButtonText(this.post2Id))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFF7FAFF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .onClick({ =>
                                        this.openComments(this.post2Id, this.post2Title)
                                    })
                            }
                            .width(100.percent)
                            .margin(bottom: 10)

                            Text(this.post2Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text(this.post2Content)
                                .fontSize(14)
                                .fontColor(0xFF6D7B99)
                                .margin(bottom: 10)

                            if (this.post2ImageUrl != "") {
                                Image(this.post2ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Row {
                                if (this.post2AvatarUrl != "") {
                                    Image(this.post2AvatarUrl)
                                        .width(34)
                                        .height(34)
                                        .borderRadius(17)
                                        .margin(right: 10)
                                } else {
                                    Row {
                                        Text("人")
                                            .fontSize(13)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFFFFFFFF)
                                    }
                                    .width(34)
                                    .height(34)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFF8DBBFF)
                                    .borderRadius(17)
                                    .margin(right: 10)
                                }

                                Text(this.post2Author)
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .layoutWeight(1)
                            }
                            .width(100.percent)
                            .alignItems(VerticalAlign.Center)
                            .margin(bottom: 8)

                            Text(this.post2Author + " · " + this.post2Time)
                                .fontSize(12)
                                .fontColor(0xFF2F80FF)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.activeCommentPostId != "" && this.activeCommentPostId == this.post2Id) {
                        Column {
                            Text("评论 · " + this.post2Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 10)
                            TextInput(placeholder: "写下你的评论").width(100.percent).height(72).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 10).onChange({ v: String => this.commentInput = v })
                            Button("发表评论").width(100.percent).height(40).enabled(!this.commentSubmitting).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).borderRadius(16).margin(bottom: 12).onClick({ => this.submitComment() })
                            if (this.commentMsg != "") { Text(this.commentMsg).fontSize(13).fontColor(0xFF2F80FF).margin(bottom: 10) }
                            if (this.commentLoading) {
                                Text("评论加载中...").fontSize(13).fontColor(0xFF7E8CA8)
                            } else if (!this.hasComments()) {
                                Text("还没有评论，来写第一条吧。").fontSize(13).fontColor(0xFF7E8CA8)
                            } else {
                                if (this.comment1Content != "") {
                                    Row {
                                        if (this.comment1AvatarUrl != "") { Image(this.comment1AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF7AAFFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment1Name + " · " + this.comment1Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment1Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment2Content != "") {
                                    Row {
                                        if (this.comment2AvatarUrl != "") { Image(this.comment2AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF8DBBFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment2Name + " · " + this.comment2Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment2Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment3Content != "") {
                                    Row {
                                        if (this.comment3AvatarUrl != "") { Image(this.comment3AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF5A96FF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment3Name + " · " + this.comment3Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment3Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center)
                                }
                            }
                        }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 12)
                    }

                    if (this.post3Title != "") {
                        Column {
                            Text(this.postStatsText(this.post3LikeCount, this.post3CommentCount))
                                .fontSize(12)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 8)

                            Row {
                                Button(this.likeButtonText(this.post3LikedByMe))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFEAF2FF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .margin(right: 8)
                                    .onClick({ =>
                                        this.likePost(this.post3Id)
                                    })

                                Button(this.commentButtonText(this.post3Id))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFF7FAFF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .onClick({ =>
                                        this.openComments(this.post3Id, this.post3Title)
                                    })
                            }
                            .width(100.percent)
                            .margin(bottom: 10)

                            Text(this.post3Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text(this.post3Content)
                                .fontSize(14)
                                .fontColor(0xFF6D7B99)
                                .margin(bottom: 10)

                            if (this.post3ImageUrl != "") {
                                Image(this.post3ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Row {
                                if (this.post3AvatarUrl != "") {
                                    Image(this.post3AvatarUrl)
                                        .width(34)
                                        .height(34)
                                        .borderRadius(17)
                                        .margin(right: 10)
                                } else {
                                    Row {
                                        Text("人")
                                            .fontSize(13)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFFFFFFFF)
                                    }
                                    .width(34)
                                    .height(34)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFF5A96FF)
                                    .borderRadius(17)
                                    .margin(right: 10)
                                }

                                Text(this.post3Author)
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .layoutWeight(1)
                            }
                            .width(100.percent)
                            .alignItems(VerticalAlign.Center)
                            .margin(bottom: 8)

                            Text(this.post3Author + " · " + this.post3Time)
                                .fontSize(12)
                                .fontColor(0xFF2F80FF)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.activeCommentPostId != "" && this.activeCommentPostId == this.post3Id) {
                        Column {
                            Text("评论 · " + this.post3Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 10)
                            TextInput(placeholder: "写下你的评论").width(100.percent).height(72).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 10).onChange({ v: String => this.commentInput = v })
                            Button("发表评论").width(100.percent).height(40).enabled(!this.commentSubmitting).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).borderRadius(16).margin(bottom: 12).onClick({ => this.submitComment() })
                            if (this.commentMsg != "") { Text(this.commentMsg).fontSize(13).fontColor(0xFF2F80FF).margin(bottom: 10) }
                            if (this.commentLoading) {
                                Text("评论加载中...").fontSize(13).fontColor(0xFF7E8CA8)
                            } else if (!this.hasComments()) {
                                Text("还没有评论，来写第一条吧。").fontSize(13).fontColor(0xFF7E8CA8)
                            } else {
                                if (this.comment1Content != "") {
                                    Row {
                                        if (this.comment1AvatarUrl != "") { Image(this.comment1AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF7AAFFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment1Name + " · " + this.comment1Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment1Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment2Content != "") {
                                    Row {
                                        if (this.comment2AvatarUrl != "") { Image(this.comment2AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF8DBBFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment2Name + " · " + this.comment2Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment2Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment3Content != "") {
                                    Row {
                                        if (this.comment3AvatarUrl != "") { Image(this.comment3AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF5A96FF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment3Name + " · " + this.comment3Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment3Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center)
                                }
                            }
                        }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 12)
                    }

                    if (this.post4Title != "") {
                        Column {
                            Text(this.postStatsText(this.post4LikeCount, this.post4CommentCount))
                                .fontSize(12)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 8)

                            Row {
                                Button(this.likeButtonText(this.post4LikedByMe))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFEAF2FF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .margin(right: 8)
                                    .onClick({ =>
                                        this.likePost(this.post4Id)
                                    })

                                Button(this.commentButtonText(this.post4Id))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFF7FAFF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .onClick({ =>
                                        this.openComments(this.post4Id, this.post4Title)
                                    })
                            }
                            .width(100.percent)
                            .margin(bottom: 10)

                            Text(this.post4Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text(this.post4Content)
                                .fontSize(14)
                                .fontColor(0xFF6D7B99)
                                .margin(bottom: 10)

                            if (this.post4ImageUrl != "") {
                                Image(this.post4ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Row {
                                if (this.post4AvatarUrl != "") {
                                    Image(this.post4AvatarUrl)
                                        .width(34)
                                        .height(34)
                                        .borderRadius(17)
                                        .margin(right: 10)
                                } else {
                                    Row {
                                        Text("人")
                                            .fontSize(13)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFFFFFFFF)
                                    }
                                    .width(34)
                                    .height(34)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFF6FA6FF)
                                    .borderRadius(17)
                                    .margin(right: 10)
                                }

                                Text(this.post4Author)
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .layoutWeight(1)
                            }
                            .width(100.percent)
                            .alignItems(VerticalAlign.Center)
                            .margin(bottom: 8)

                            Text(this.post4Author + " · " + this.post4Time)
                                .fontSize(12)
                                .fontColor(0xFF2F80FF)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.activeCommentPostId != "" && this.activeCommentPostId == this.post4Id) {
                        Column {
                            Text("评论 · " + this.post4Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 10)
                            TextInput(placeholder: "写下你的评论").width(100.percent).height(72).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 10).onChange({ v: String => this.commentInput = v })
                            Button("发表评论").width(100.percent).height(40).enabled(!this.commentSubmitting).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).borderRadius(16).margin(bottom: 12).onClick({ => this.submitComment() })
                            if (this.commentMsg != "") { Text(this.commentMsg).fontSize(13).fontColor(0xFF2F80FF).margin(bottom: 10) }
                            if (this.commentLoading) {
                                Text("评论加载中...").fontSize(13).fontColor(0xFF7E8CA8)
                            } else if (!this.hasComments()) {
                                Text("还没有评论，来写第一条吧。").fontSize(13).fontColor(0xFF7E8CA8)
                            } else {
                                if (this.comment1Content != "") {
                                    Row {
                                        if (this.comment1AvatarUrl != "") { Image(this.comment1AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF7AAFFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment1Name + " · " + this.comment1Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment1Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment2Content != "") {
                                    Row {
                                        if (this.comment2AvatarUrl != "") { Image(this.comment2AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF8DBBFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment2Name + " · " + this.comment2Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment2Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment3Content != "") {
                                    Row {
                                        if (this.comment3AvatarUrl != "") { Image(this.comment3AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF5A96FF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment3Name + " · " + this.comment3Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment3Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center)
                                }
                            }
                        }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 12)
                    }

                    if (this.post5Title != "") {
                        Column {
                            Text(this.postStatsText(this.post5LikeCount, this.post5CommentCount))
                                .fontSize(12)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 8)

                            Row {
                                Button(this.likeButtonText(this.post5LikedByMe))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFEAF2FF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .margin(right: 8)
                                    .onClick({ =>
                                        this.likePost(this.post5Id)
                                    })

                                Button(this.commentButtonText(this.post5Id))
                                    .layoutWeight(1)
                                    .height(34)
                                    .backgroundColor(0xFFF7FAFF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(16)
                                    .onClick({ =>
                                        this.openComments(this.post5Id, this.post5Title)
                                    })
                            }
                            .width(100.percent)
                            .margin(bottom: 10)

                            Text(this.post5Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text(this.post5Content)
                                .fontSize(14)
                                .fontColor(0xFF6D7B99)
                                .margin(bottom: 10)

                            if (this.post5ImageUrl != "") {
                                Image(this.post5ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Row {
                                if (this.post5AvatarUrl != "") {
                                    Image(this.post5AvatarUrl)
                                        .width(34)
                                        .height(34)
                                        .borderRadius(17)
                                        .margin(right: 10)
                                } else {
                                    Row {
                                        Text("人")
                                            .fontSize(13)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFFFFFFFF)
                                    }
                                    .width(34)
                                    .height(34)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFF9AC7FF)
                                    .borderRadius(17)
                                    .margin(right: 10)
                                }

                                Text(this.post5Author)
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .layoutWeight(1)
                            }
                            .width(100.percent)
                            .alignItems(VerticalAlign.Center)
                            .margin(bottom: 8)

                            Text(this.post5Author + " · " + this.post5Time)
                                .fontSize(12)
                                .fontColor(0xFF2F80FF)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.activeCommentPostId != "" && this.activeCommentPostId == this.post5Id) {
                        Column {
                            Text("评论 · " + this.post5Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 10)
                            TextInput(placeholder: "写下你的评论").width(100.percent).height(72).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 10).onChange({ v: String => this.commentInput = v })
                            Button("发表评论").width(100.percent).height(40).enabled(!this.commentSubmitting).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).borderRadius(16).margin(bottom: 12).onClick({ => this.submitComment() })
                            if (this.commentMsg != "") { Text(this.commentMsg).fontSize(13).fontColor(0xFF2F80FF).margin(bottom: 10) }
                            if (this.commentLoading) {
                                Text("评论加载中...").fontSize(13).fontColor(0xFF7E8CA8)
                            } else if (!this.hasComments()) {
                                Text("还没有评论，来写第一条吧。").fontSize(13).fontColor(0xFF7E8CA8)
                            } else {
                                if (this.comment1Content != "") {
                                    Row {
                                        if (this.comment1AvatarUrl != "") { Image(this.comment1AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF7AAFFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment1Name + " · " + this.comment1Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment1Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment2Content != "") {
                                    Row {
                                        if (this.comment2AvatarUrl != "") { Image(this.comment2AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF8DBBFF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment2Name + " · " + this.comment2Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment2Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                }
                                if (this.comment3Content != "") {
                                    Row {
                                        if (this.comment3AvatarUrl != "") { Image(this.comment3AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10) } else { Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF5A96FF).borderRadius(17).margin(right: 10) }
                                        Column { Text(this.comment3Name + " · " + this.comment3Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4); Text(this.comment3Content).fontSize(14).fontColor(0xFF24324A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center)
                                }
                            }
                        }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 12)
                    }

                    if (this.activeCommentPostId == "__never__") {
                        Column {
                            Text("评论 · " + this.activeCommentPostTitle)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 10)

                            TextInput(placeholder: "写下你的评论")
                                .width(100.percent)
                                .height(76)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .margin(bottom: 10)
                                .onChange({ v: String =>
                                    this.commentInput = v
                                })

                            Button("发表评论")
                                .width(100.percent)
                                .height(40)
                                .enabled(!this.commentSubmitting)
                                .backgroundColor(0xFF2F80FF)
                                .fontColor(0xFFFFFFFF)
                                .borderRadius(16)
                                .margin(bottom: 12)
                                .onClick({ =>
                                    this.submitComment()
                                })

                            if (this.commentMsg != "") {
                                Text(this.commentMsg)
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .margin(bottom: 10)
                            }

                            if (this.commentLoading) {
                                Text("评论加载中...")
                                    .fontSize(13)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 8)
                            } else if (!this.hasComments()) {
                                Text("还没有评论，来写第一条吧。")
                                    .fontSize(13)
                                    .fontColor(0xFF7E8CA8)
                                    .backgroundColor(0xFFF7FAFF)
                                    .padding(12)
                                    .borderRadius(14)
                            } else {
                                if (this.comment1Content != "") {
                                    Row {
                                        if (this.comment1AvatarUrl != "") {
                                            Image(this.comment1AvatarUrl)
                                                .width(38)
                                                .height(38)
                                                .borderRadius(19)
                                                .margin(right: 10)
                                        } else {
                                            Row {
                                                Text("人")
                                                    .fontSize(13)
                                                    .fontWeight(FontWeight.Bold)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(38)
                                            .height(38)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .backgroundColor(0xFF7AAFFF)
                                            .borderRadius(19)
                                            .margin(right: 10)
                                        }

                                        Column {
                                            Text(this.comment1Name + "  " + this.comment1Time)
                                                .fontSize(12)
                                                .fontColor(0xFF2F80FF)
                                                .margin(bottom: 5)

                                            Text(this.comment1Content)
                                                .fontSize(14)
                                                .fontColor(0xFF24324A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .width(100.percent)
                                    .padding(10)
                                    .backgroundColor(0xFFF7FAFF)
                                    .borderRadius(14)
                                    .alignItems(VerticalAlign.Center)
                                    .margin(bottom: 8)
                                }

                                if (this.comment2Content != "") {
                                    Row {
                                        if (this.comment2AvatarUrl != "") {
                                            Image(this.comment2AvatarUrl)
                                                .width(38)
                                                .height(38)
                                                .borderRadius(19)
                                                .margin(right: 10)
                                        } else {
                                            Row {
                                                Text("人")
                                                    .fontSize(13)
                                                    .fontWeight(FontWeight.Bold)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(38)
                                            .height(38)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .backgroundColor(0xFF8DBBFF)
                                            .borderRadius(19)
                                            .margin(right: 10)
                                        }

                                        Column {
                                            Text(this.comment2Name + "  " + this.comment2Time)
                                                .fontSize(12)
                                                .fontColor(0xFF2F80FF)
                                                .margin(bottom: 5)

                                            Text(this.comment2Content)
                                                .fontSize(14)
                                                .fontColor(0xFF24324A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .width(100.percent)
                                    .padding(10)
                                    .backgroundColor(0xFFF7FAFF)
                                    .borderRadius(14)
                                    .alignItems(VerticalAlign.Center)
                                    .margin(bottom: 8)
                                }

                                if (this.comment3Content != "") {
                                    Row {
                                        if (this.comment3AvatarUrl != "") {
                                            Image(this.comment3AvatarUrl)
                                                .width(38)
                                                .height(38)
                                                .borderRadius(19)
                                                .margin(right: 10)
                                        } else {
                                            Row {
                                                Text("人")
                                                    .fontSize(13)
                                                    .fontWeight(FontWeight.Bold)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(38)
                                            .height(38)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .backgroundColor(0xFF5A96FF)
                                            .borderRadius(19)
                                            .margin(right: 10)
                                        }

                                        Column {
                                            Text(this.comment3Name + "  " + this.comment3Time)
                                                .fontSize(12)
                                                .fontColor(0xFF2F80FF)
                                                .margin(bottom: 5)

                                            Text(this.comment3Content)
                                                .fontSize(14)
                                                .fontColor(0xFF24324A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .width(100.percent)
                                    .padding(10)
                                    .backgroundColor(0xFFF7FAFF)
                                    .borderRadius(14)
                                    .alignItems(VerticalAlign.Center)
                                    .margin(bottom: 8)
                                }

                                if (this.comment4Content != "") {
                                    Row {
                                        if (this.comment4AvatarUrl != "") {
                                            Image(this.comment4AvatarUrl)
                                                .width(38)
                                                .height(38)
                                                .borderRadius(19)
                                                .margin(right: 10)
                                        } else {
                                            Row {
                                                Text("人")
                                                    .fontSize(13)
                                                    .fontWeight(FontWeight.Bold)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(38)
                                            .height(38)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .backgroundColor(0xFF6FA6FF)
                                            .borderRadius(19)
                                            .margin(right: 10)
                                        }

                                        Column {
                                            Text(this.comment4Name + "  " + this.comment4Time)
                                                .fontSize(12)
                                                .fontColor(0xFF2F80FF)
                                                .margin(bottom: 5)

                                            Text(this.comment4Content)
                                                .fontSize(14)
                                                .fontColor(0xFF24324A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .width(100.percent)
                                    .padding(10)
                                    .backgroundColor(0xFFF7FAFF)
                                    .borderRadius(14)
                                    .alignItems(VerticalAlign.Center)
                                    .margin(bottom: 8)
                                }

                                if (this.comment5Content != "") {
                                    Row {
                                        if (this.comment5AvatarUrl != "") {
                                            Image(this.comment5AvatarUrl)
                                                .width(38)
                                                .height(38)
                                                .borderRadius(19)
                                                .margin(right: 10)
                                        } else {
                                            Row {
                                                Text("人")
                                                    .fontSize(13)
                                                    .fontWeight(FontWeight.Bold)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(38)
                                            .height(38)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .backgroundColor(0xFF9AC7FF)
                                            .borderRadius(19)
                                            .margin(right: 10)
                                        }

                                        Column {
                                            Text(this.comment5Name + "  " + this.comment5Time)
                                                .fontSize(12)
                                                .fontColor(0xFF2F80FF)
                                                .margin(bottom: 5)

                                            Text(this.comment5Content)
                                                .fontSize(14)
                                                .fontColor(0xFF24324A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .width(100.percent)
                                    .padding(10)
                                    .backgroundColor(0xFFF7FAFF)
                                    .borderRadius(14)
                                    .alignItems(VerticalAlign.Center)
                                }
                            }
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)

                        if (this.activeCommentPostId != "" && this.activeCommentPostId == this.post1Id) {
                            Column {
                                Text("评论 · " + this.post1Title)
                                    .fontSize(17)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF24324A)
                                    .margin(bottom: 10)

                                TextInput(placeholder: "写下你的评论")
                                    .width(100.percent)
                                    .height(72)
                                    .backgroundColor(0xFFF7FAFF)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                                    .onChange({ v: String =>
                                        this.commentInput = v
                                    })

                                Button("发表评论")
                                    .width(100.percent)
                                    .height(40)
                                    .enabled(!this.commentSubmitting)
                                    .backgroundColor(0xFF2F80FF)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(16)
                                    .margin(bottom: 12)
                                    .onClick({ =>
                                        this.submitComment()
                                    })

                                if (this.commentMsg != "") {
                                    Text(this.commentMsg)
                                        .fontSize(13)
                                        .fontColor(0xFF2F80FF)
                                        .margin(bottom: 10)
                                }

                                if (this.commentLoading) {
                                    Text("评论加载中...")
                                        .fontSize(13)
                                        .fontColor(0xFF7E8CA8)
                                } else if (!this.hasComments()) {
                                    Text("还没有评论，来写第一条吧。")
                                        .fontSize(13)
                                        .fontColor(0xFF7E8CA8)
                                } else {
                                    if (this.comment1Content != "") {
                                        Row {
                                            if (this.comment1AvatarUrl != "") {
                                                Image(this.comment1AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10)
                                            } else {
                                                Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF7AAFFF).borderRadius(17).margin(right: 10)
                                            }
                                            Column {
                                                Text(this.comment1Name + " · " + this.comment1Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4)
                                                Text(this.comment1Content).fontSize(14).fontColor(0xFF24324A)
                                            }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                        }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    }
                                    if (this.comment2Content != "") {
                                        Row {
                                            if (this.comment2AvatarUrl != "") {
                                                Image(this.comment2AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10)
                                            } else {
                                                Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF8DBBFF).borderRadius(17).margin(right: 10)
                                            }
                                            Column {
                                                Text(this.comment2Name + " · " + this.comment2Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4)
                                                Text(this.comment2Content).fontSize(14).fontColor(0xFF24324A)
                                            }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                        }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    }
                                    if (this.comment3Content != "") {
                                        Row {
                                            if (this.comment3AvatarUrl != "") {
                                                Image(this.comment3AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10)
                                            } else {
                                                Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF5A96FF).borderRadius(17).margin(right: 10)
                                            }
                                            Column {
                                                Text(this.comment3Name + " · " + this.comment3Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4)
                                                Text(this.comment3Content).fontSize(14).fontColor(0xFF24324A)
                                            }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                        }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    }
                                    if (this.comment4Content != "") {
                                        Row {
                                            if (this.comment4AvatarUrl != "") {
                                                Image(this.comment4AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10)
                                            } else {
                                                Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF6FA6FF).borderRadius(17).margin(right: 10)
                                            }
                                            Column {
                                                Text(this.comment4Name + " · " + this.comment4Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4)
                                                Text(this.comment4Content).fontSize(14).fontColor(0xFF24324A)
                                            }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                        }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    }
                                    if (this.comment5Content != "") {
                                        Row {
                                            if (this.comment5AvatarUrl != "") {
                                                Image(this.comment5AvatarUrl).width(34).height(34).borderRadius(17).margin(right: 10)
                                            } else {
                                                Row { Text("人").fontSize(12).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(34).height(34).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).backgroundColor(0xFF9AC7FF).borderRadius(17).margin(right: 10)
                                            }
                                            Column {
                                                Text(this.comment5Name + " · " + this.comment5Time).fontSize(12).fontColor(0xFF2F80FF).margin(bottom: 4)
                                                Text(this.comment5Content).fontSize(14).fontColor(0xFF24324A)
                                            }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                        }.width(100.percent).padding(10).backgroundColor(0xFFF7FAFF).borderRadius(14).alignItems(VerticalAlign.Center)
                                    }
                                }
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }
                    }
                }
                .width(100.percent)
                .padding(left: 16, right: 16, top: 16, bottom: 24)
            }
            .layoutWeight(1)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF4F8FF)
    }
}
