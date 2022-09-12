import React from 'react'
import Avatar from '../Avatar/Avatar'

const panelPadding = 8
const panelPaddingHorizontal = panelPadding * 2

interface Props {
  hasPanel?: boolean
  onClick?: () => void
  picture: string
  size: number
  unstyled?: boolean
}

const EditableAvatar = (props: Props) => {
  const {hasPanel, onClick, picture, size, unstyled} = props
  const avatarSize = hasPanel ? size - panelPaddingHorizontal : size
  return (
    <Avatar picture={picture} size={avatarSize} sansRadius={unstyled} sansShadow={unstyled} />
  )
}

export default EditableAvatar
