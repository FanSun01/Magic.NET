/**
 * 向后端请求用户的菜单，动态生成路由
 */
import { constantRouterMap } from '@/config/router.config'
import { generatorDynamicRouter } from '@/router/generator-routers'

const permission = {
  state: {
    routers: constantRouterMap,
    addRouters: []
  },
  mutations: {
    SET_ROUTERS: (state, routers) => {
      state.addRouters = routers
      state.routers = constantRouterMap.concat(routers)
      console.log("SET_ROUTERS",routers);
    }
  },
  actions: {
    GenerateRoutes ({ commit }, data) {
      console.log("GenerateRoutes1",data)
      return new Promise(resolve => {
        generatorDynamicRouter(data).then(routers => {
          console.log("GenerateRoutes2",routers)
          commit('SET_ROUTERS', routers)
          resolve()
        })
      }).catch(err => {
        // eslint-disable-next-line no-undef
        reject(err)
      })
    }
  }
}

export default permission
