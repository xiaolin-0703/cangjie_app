package ohos_app_cangjie_entry.common

import ohos.ability.AbilityContext

private var globalAbilityContext: Option<AbilityContext> = Option<AbilityContext>.None

public func setGlobalAbilityContext(context: Option<AbilityContext>): Unit {
    globalAbilityContext = context
}

public func getGlobalAbilityContext(): Option<AbilityContext> {
    return globalAbilityContext
}
