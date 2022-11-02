/**
 * 根据id返回树节点
 * @param id
 * @param tree
 * @returns node: Object 树节点
 */
export const findNode = (id, tree) => {
  for (let i = 0; i < tree.length; i++) {
    if (tree[i].id === id) {
      return tree[i]
    }
    if (tree[i].children && tree[i].children.length > 0) {
      const node = findNode(id, tree[i].children)
      if (node) {
        return node
      }
    }
  }
}

/**
 * 根据id返回所有父节点
 * @param id
 * @param tree
 * @returns *[] 父节点数组 (最近的父节点在数组末尾)
 */
export const findParents = (id, tree) => {
  for (let i = 0; i < tree.length; i++) {
    if (tree[i].id === id) {
      return [tree[i]]
    }
    if (tree[i].children && tree[i].children.length > 0) {
      const parents = findParents(id, tree[i].children)
      if (parents) {
        parents.unshift(tree[i])
        return parents
      }
    }
  }
}